#!/usr/bin/env bun
/**
 * LaTeX to Typst Migration Tool — MathRepo
 *
 * Mechanical batch conversion for migrating LaTeX (elegantbook) notes to Typst.
 * Handles: headings, environments, symbols, labels, references, font commands, lists.
 *
 * Usage:
 *   bun migrate.js input.tex output.typ              # full conversion
 *   bun migrate.js input.tex output.typ --dry-run    # preview without writing
 *   bun migrate.js input.tex output.typ --env-only   # environments + structure only
 *   bun migrate.js input.tex output.typ --no-symbols # skip symbol replacement
 *
 * Requires: Bun (or Node.js 18+).
 */

const fs = require('fs');

// ===========================================================================
// Helper functions
// ===========================================================================

function findMatchingBrace(text, start) {
  if (start >= text.length || text[start] !== '{') return -1;
  let depth = 0;
  for (let i = start; i < text.length; i++) {
    if (text[i] === '{') depth++;
    else if (text[i] === '}') { depth--; if (depth === 0) return i; }
  }
  return -1;
}

function extractBracedArg(text, pos) {
  if (pos >= text.length || text[pos] !== '{') return [null, pos];
  const end = findMatchingBrace(text, pos);
  if (end === -1) return [null, pos];
  return [text.slice(pos + 1, end), end + 1];
}

function isRealCmdStart(text, idx) {
  let j = idx - 1;
  while (j >= 0 && /[a-zA-Z]/.test(text[j])) j--;
  if (j >= 0 && text[j] === '\\') return false;
  return true;
}

function replaceBracedCmd(text, cmdName, formatter) {
  const cmd = '\\' + cmdName;
  const matches = [];
  let searchFrom = 0;
  while (true) {
    const idx = text.indexOf(cmd, searchFrom);
    if (idx === -1) break;
    if (!isRealCmdStart(text, idx)) {
      searchFrom = idx + 1;
      continue;
    }
    const afterCmd = idx + cmd.length;
    if (afterCmd >= text.length || text[afterCmd] !== '{') {
      searchFrom = afterCmd;
      continue;
    }
    const end = findMatchingBrace(text, afterCmd);
    if (end === -1) { searchFrom = afterCmd; continue; }
    const arg = text.slice(afterCmd + 1, end);
    matches.push({ start: idx, end: end + 1, arg });
    searchFrom = end + 1;
  }
  for (let i = matches.length - 1; i >= 0; i--) {
    const { start, end, arg } = matches[i];
    text = text.slice(0, start) + formatter(arg) + text.slice(end);
  }
  return text;
}

function replaceBracedCmd2(text, cmdName, formatter) {
  const cmd = '\\' + cmdName;
  const matches = [];
  let searchFrom = 0;
  while (true) {
    const idx = text.indexOf(cmd, searchFrom);
    if (idx === -1) break;
    if (!isRealCmdStart(text, idx)) {
      searchFrom = idx + 1;
      continue;
    }
    const afterCmd = idx + cmd.length;
    if (afterCmd >= text.length || text[afterCmd] !== '{') {
      searchFrom = afterCmd;
      continue;
    }
    const end1 = findMatchingBrace(text, afterCmd);
    if (end1 === -1) { searchFrom = afterCmd; continue; }
    const arg1 = text.slice(afterCmd + 1, end1);
    const afterArg1 = end1 + 1;
    if (afterArg1 >= text.length || text[afterArg1] !== '{') {
      searchFrom = afterArg1;
      continue;
    }
    const end2 = findMatchingBrace(text, afterArg1);
    if (end2 === -1) { searchFrom = afterArg1; continue; }
    const arg2 = text.slice(afterArg1 + 1, end2);
    matches.push({ start: idx, end: end2 + 1, arg1, arg2 });
    searchFrom = end2 + 1;
  }
  for (let i = matches.length - 1; i >= 0; i--) {
    const { start, end, arg1, arg2 } = matches[i];
    text = text.slice(0, start) + formatter(arg1, arg2) + text.slice(end);
  }
  return text;
}

// ===========================================================================
// Environment helpers
// ===========================================================================

function replaceAllEnvsSafe(text, envName, replacer) {
  const beginRe = new RegExp('\\\\begin\\{' + escapeRe(envName) + '\\}');
  const endRe = new RegExp('\\\\end\\{' + escapeRe(envName) + '\\}', 'g');

  const matches = [];
  let searchStart = 0;

  while (true) {
    const m = beginRe.exec(text.slice(searchStart));
    if (!m) break;
    const absBeginStart = searchStart + m.index;
    const afterBegin = absBeginStart + m[0].length;

    let bodyStart = afterBegin;
    if (afterBegin < text.length && text[afterBegin] === '{') {
      const end = findMatchingBrace(text, afterBegin);
      if (end !== -1) bodyStart = end + 1;
    }

    endRe.lastIndex = bodyStart;
    const endM = endRe.exec(text);
    if (!endM) { searchStart = afterBegin; continue; }

    const body = text.slice(bodyStart, endM.index);
    matches.push({ start: absBeginStart, end: endM.index + endM[0].length, body });
    searchStart = endM.index + endM[0].length;
  }

  for (let i = matches.length - 1; i >= 0; i--) {
    const { start, end, body } = matches[i];
    const replacement = replacer(body, text.slice(start, end));
    text = text.slice(0, start) + replacement + text.slice(end);
  }
  return text;
}

function escapeRe(s) { return s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'); }

// ===========================================================================
// Conversion functions
// ===========================================================================

function convertComments(text) {
  return text.split('\n').map(line => {
    let result = '';
    for (let i = 0; i < line.length; i++) {
      if (line[i] === '%' && (i === 0 || line[i - 1] !== '\\')) break;
      result += line[i];
    }
    return result;
  }).join('\n');
}

function convertHeadings(text) {
  text = text.replace(/\\part\{([^}]*)\}/g, '#part("$1")');
  text = text.replace(/\\chapter\{([^}]*)\}/g, '= $1');
  text = text.replace(/\\section\{([^}]*)\}/g, '== $1');
  text = text.replace(/\\subsection\{([^}]*)\}/g, '=== $1');
  text = text.replace(/\\subsubsection\{([^}]*)\}/g, '==== $1');
  text = text.replace(/\\paragraph\{([^}]*)\}/g, '*$1*');
  return text;
}

function convertLabelsAndRefs(text) {
  text = text.replace(/\\label\{([^}]*)\}/g, '<$1>');
  text = text.replace(/\\eqref\{([^}]*)\}/g, '@eq:$1');
  text = text.replace(/\\ref\{([^}]*)\}/g, '@$1');
  text = text.replace(/\\begin\{equation\}/g, '$');
  text = text.replace(/\\end\{equation\}/g, '$');
  return text;
}

function convertLeftbar(text) {
  const re = /\\begin\{leftbarTitle\}\{([^}]*)\}\s*(.*?)\\end\{leftbarTitle\}/gs;
  return text.replace(re, (_, title, body) => `=== ${title}\n${body.trim()}`);
}

function convertTheoremEnvs(text) {
  const envs = [
    'theorem', 'corollary', 'lemma',
    'definition', 'property',
    'proposition', 'example',
    'axiom', 'postulate',
    'exercise', 'problem',
    'remark', 'note',
  ];
  const componentMap = {
    theorem: 'theorem', corollary: 'corollary', lemma: 'lemma',
    definition: 'definition', property: 'property',
    proposition: 'proposition', example: 'example',
    axiom: 'axiom', postulate: 'postulate',
    exercise: 'exercise', problem: 'example',
    remark: 'note', note: 'note',
  };

  for (const env of envs) {
    const comp = componentMap[env];
    text = replaceAllEnvsSafe(text, env, (body, fullMatch) => {
      let name = '';
      const beginRe = new RegExp('\\\\begin\\{' + escapeRe(env) + '\\}');
      const bm = beginRe.exec(fullMatch);
      if (bm) {
        const after = bm.index + bm[0].length;
        if (after < fullMatch.length && fullMatch[after] === '{') {
          const end = findMatchingBrace(fullMatch, after);
          if (end !== -1) name = fullMatch.slice(after + 1, end);
        } else if (after < fullMatch.length && fullMatch[after] === '[') {
          const bracketEnd = fullMatch.indexOf(']', after);
          if (bracketEnd !== -1) name = fullMatch.slice(after + 1, bracketEnd);
        }
      }
      body = body.trim();
      if (name) {
        body = body.replace(/^\s*\[[^\]]*\]\s*/, '');
        return `#${comp}(name: "${name}")[\n${body.trim()}\n]`;
      }
      return `#${comp}[\n${body}\n]`;
    });
  }
  return text;
}

function convertProof(text) {
  return replaceAllEnvsSafe(text, 'proof', (body) => {
    body = body.trim().replace(/\s*\\qeds?\s*$/, '');
    return `#proof[\n${body}\n]`;
  });
}

function convertSolution(text) {
  return replaceAllEnvsSafe(text, 'solution', (body) => {
    return `#solution[\n${body.trim()}\n]`;
  });
}

function convertLists(text) {
  text = replaceAllEnvsSafe(text, 'enumerate', (body) => {
    return body.split(/\\item\s+/).filter(s => s.trim()).map(s => `1. ${s.trim()}`).join('\n\n');
  });

  text = replaceAllEnvsSafe(text, 'itemize', (body) => {
    return body.split(/\\item\s+/).filter(s => s.trim()).map(s => `- ${s.trim()}`).join('\n\n');
  });

  text = replaceAllEnvsSafe(text, 'description', (body) => {
    const items = body.split(/\\item\s*/).filter(s => s.trim());
    let idx = 1;
    const result = items.map(item => {
      item = item.trim();
      if (!item) return null;
      const labelM = item.match(/^\[([^\]]*)\]\s*([\s\S]*)/);
      if (labelM) {
        const r = `${idx}. *${labelM[1].trim()}.* ${labelM[2].trim()}`;
        idx++;
        return r;
      }
      const r = `${idx}. ${item}`;
      idx++;
      return r;
    }).filter(Boolean);
    return result.join('\n\n');
  });

  return text;
}

function convertMathEnvs(text) {
  const alignReplacer = (body) => {
    body = body.replace(/\\(?:notag|nonumber)\*?\s*/g, '');
    body = body.replace(/\\label\{([^}]*)\}/g, '<eq:$1>');
    body = body.replace(/\\\\/g, '\\');
    return `$\n${body.trim()}\n$`;
  };

  const gatherReplacer = (body) => {
    body = body.replace(/\\(?:notag|nonumber)\*?\s*/g, '');
    return body.split(/\\\\/).filter(s => s.trim()).map(s => `$\n${s.trim()}\n$`).join('\n\n');
  };

  text = replaceAllEnvsSafe(text, 'align*', alignReplacer);
  text = replaceAllEnvsSafe(text, 'align', alignReplacer);
  text = replaceAllEnvsSafe(text, 'gather*', gatherReplacer);
  text = replaceAllEnvsSafe(text, 'gather', gatherReplacer);
  text = replaceAllEnvsSafe(text, 'equation*', alignReplacer);

  text = replaceAllEnvsSafe(text, 'cases', (body) => {
    const branches = body.split(/\\\\/).map(b => b.trim()).filter(Boolean);
    return `cases(\n  ${branches.join(',\n  ')},\n)`;
  });

  const matrixDelims = {
    pmatrix: '(', bmatrix: '[', Bmatrix: '{',
    vmatrix: '|', Vmatrix: '||',
  };
  for (const [env, delim] of Object.entries(matrixDelims)) {
    text = replaceAllEnvsSafe(text, env, (body) => {
      const rows = body.split(/\\\\/).map(r => r.trim()).filter(Boolean);
      const typstRows = rows.map(r => r.split(/&/).map(c => c.trim()).join(', '));
      return `mat(delim: "${delim}", ${typstRows.join('; ')})`;
    });
  }

  text = text.replace(/\\\[(.+?)\\\]/gs, (_, content) => `$\n${content.trim()}\n$`);
  text = text.replace(/\\\((.+?)\\\)/gs, (_, content) => `$${content.trim()}$`);

  return text;
}

function convertLength(s) {
  s = s.trim();
  const m = s.match(/^([\d.]+)\s*\\(textwidth|linewidth|columnwidth)$/);
  if (m) return `${Math.round(parseFloat(m[1]) * 100)}%`;
  if (s === '\\textwidth' || s === '\\linewidth') return '100%';
  return s;
}

function convertFigure(text) {
  return replaceAllEnvsSafe(text, 'figure', (body, fullMatch) => {
    let caption = '';
    const capIdx = body.indexOf('\\caption');
    if (capIdx !== -1) {
      const afterCmd = capIdx + '\\caption'.length;
      if (afterCmd < body.length && body[afterCmd] === '{') {
        const capEnd = findMatchingBrace(body, afterCmd);
        if (capEnd !== -1) caption = body.slice(afterCmd + 1, capEnd);
      }
    }
    const labelM = body.match(/\\label\{([^}]*)\}/);
    const igM = body.match(/\\includegraphics(?:\[([^\]]*)\])?\{([^}]*)\}/);

    const label = labelM ? labelM[1] : '';
    const imgPath = igM ? igM[2] : '';
    const options = igM && igM[1] ? igM[1] : '';

    let width = '';
    if (options) {
      const wM = options.match(/width\s*=\s*([^,]+)/);
      if (wM) width = convertLength(wM[1]);
    }

    const lines = ['#figure('];
    if (imgPath) {
      lines.push(width ? `  image("${imgPath}", width: ${width}),` : `  image("${imgPath}", width: 60%),`);
    }
    if (caption) lines.push(`  caption: [${caption}],`);
    lines.push('  placement: auto,');
    lines.push('  supplement: [Fig.],');
    lines.push(')');
    if (label) lines.push(`<${label}>`);
    return lines.join('\n');
  });
}

function convertTableEnv(text) {
  return replaceAllEnvsSafe(text, 'table', (body) => {
    let caption = '';
    const capIdx = body.indexOf('\\caption');
    if (capIdx !== -1) {
      const afterCmd = capIdx + '\\caption'.length;
      if (afterCmd < body.length && body[afterCmd] === '{') {
        const capEnd = findMatchingBrace(body, afterCmd);
        if (capEnd !== -1) caption = body.slice(afterCmd + 1, capEnd);
      }
    }
    const labelM = body.match(/\\label\{([^}]*)\}/);
    const lines = [];
    if (caption) lines.push(`// Table: ${caption}`);
    lines.push('// TODO: Convert tabular environment to #tex-table(...)');
    const tabularM = body.match(/\\begin\{tabular\}[^}]*\}([\s\S]*?)\\end\{tabular\}/);
    if (tabularM) {
      lines.push('// Original tabular content:');
      tabularM[1].trim().split('\n').forEach(l => lines.push(`//   ${l.trim()}`));
    }
    if (labelM) lines.push(`<${labelM[1]}>`);
    return lines.join('\n');
  });
}

function convertTextFormat(text) {
  text = replaceBracedCmd(text, 'textbf', a => `*${a}*`);
  text = replaceBracedCmd(text, 'textit', a => `_${a}_`);
  text = replaceBracedCmd(text, 'emph', a => `_${a}_`);
  text = replaceBracedCmd(text, 'textrm', c => `\\rm("${c}")`);
  text = replaceBracedCmd(text, 'text', c => `text("${c}")`);
  return text;
}

function convertVspace(text) {
  return text.replace(/\\vspace\{([^}]*)\}/g, '#v($1)');
}

function convertMathFonts(text) {
  text = replaceBracedCmd(text, 'mathbb', a => `bb(${a})`);
  text = replaceBracedCmd(text, 'mathcal', a => `cal(${a})`);
  text = replaceBracedCmd(text, 'mathscr', a => `scr(${a})`);
  text = replaceBracedCmd(text, 'mathfrak', a => `frak(${a})`);
  return text;
}

function convertMathFunctions(text) {
  text = replaceBracedCmd(text, 'operatorname', c => `"${c}"`);
  text = text.replace(/\\Re(?![a-zA-Z])/g, 'Re');
  text = text.replace(/\\Im(?![a-zA-Z])/g, 'Im');
  text = replaceBracedCmd(text, 'mathrm', c => {
    if (c === 'Re') return 'Re';
    if (c === 'Im') return 'Im';
    if (c === 'Arg') return 'Arg';
    if (c === 'i') return 'i';
    if (c === 'd') return 'dif';
    if (c === 'e') return 'e';
    return `\\rm("${c}")`;
  });

  const funcs = ['arcsin', 'arccos', 'arctan',
    'ln', 'exp', 'sin', 'cos', 'tan', 'cot', 'sec', 'csc',
    'sinh', 'cosh', 'tanh',
    'log', 'lim', 'sup', 'inf', 'max', 'min', 'det', 'dim',
    'ker', 'deg', 'gcd', 'hom', 'arg'];
  for (const f of funcs) {
    text = text.replace(new RegExp('\\\\' + f + '(?![a-zA-Z])', 'g'), f);
  }
  return text;
}

function convertMiscCommands(text) {
  text = text.replace(/\\noindent\s*/g, '');
  text = text.replace(/\\centering\s*/g, '');
  text = text.replace(/\\(?:tiny|scriptsize|footnotesize|small|normalsize|large|Large|LARGE|huge|Huge)\s*/g, '');
  text = text.replace(/\\hspace\{[^}]*\}/g, '');
  text = text.replace(/\\bigskip\s*/g, '\n');
  text = text.replace(/\\medskip\s*/g, '\n');
  text = text.replace(/\\smallskip\s*/g, '\n');
  text = text.replace(/\\newline\s*/g, '\n');
  text = text.replace(/\\linebreak\s*/g, '\n');
  text = text.replace(/\\pagebreak\s*/g, '');
  text = text.replace(/\\clearpage\s*/g, '');
  text = text.replace(/\\newpage\s*/g, '');
  text = text.replace(/\\\\\[([^\]]*)\]/g, '');
  return text;
}

function convertSymbols(text) {
  const replacements = [
    [/\\infty(?![a-zA-Z])/g, 'oo'],
    [/\\varnothing(?![a-zA-Z])/g, 'emptyset'],
    [/\\cup(?![a-zA-Z])/g, 'union'],
    [/\\cap(?![a-zA-Z])/g, 'inter'],
    [/\\bigcup(?![a-zA-Z])/g, 'union'],
    [/\\bigcap(?![a-zA-Z])/g, 'inter'],
    [/\\land(?![a-zA-Z])/g, 'and'],
    [/\\lor(?![a-zA-Z])/g, 'or'],
    [/\\lnot(?![a-zA-Z])/g, 'not'],
    [/\\neg(?![a-zA-Z])/g, 'not'],
    [/\\subseteq(?![a-zA-Z])/g, 'subset.eq'],
    [/\\supseteq(?![a-zA-Z])/g, 'supset.eq'],
    [/\\subsetneq(?![a-zA-Z])/g, 'subset.neq'],
    [/\\supsetneq(?![a-zA-Z])/g, 'supset.neq'],
    [/\\subset(?![a-zA-Z])/g, 'subset'],
    [/\\supset(?![a-zA-Z])/g, 'supset'],
    [/\\setminus(?![a-zA-Z])/g, 'backslash'],
    [/\\in(?![a-zA-Z])/g, 'in'],
    [/\\notin(?![a-zA-Z])/g, 'in.not'],
    [/\\neq(?![a-zA-Z])/g, '!='],
    [/\\leq(?![a-zA-Z])/g, '<='],
    [/\\geq(?![a-zA-Z])/g, '>='],
    [/\\ll(?![a-zA-Z])/g, '<<'],
    [/\\gg(?![a-zA-Z])/g, '>>'],
    [/\\approx(?![a-zA-Z])/g, 'approx'],
    [/\\equiv(?![a-zA-Z])/g, 'equiv'],
    [/\\sim(?![a-zA-Z])/g, '~'],
    [/\\simeq(?![a-zA-Z])/g, 'tilde.eq'],
    [/\\propto(?![a-zA-Z])/g, 'prop'],
    [/\\to(?![a-zA-Z])/g, '->'],
    [/\\mapsto(?![a-zA-Z])/g, '|->'],
    [/\\longrightarrow(?![a-zA-Z])/g, '->'],
    [/\\longleftarrow(?![a-zA-Z])/g, '<-'],
    [/\\Rightarrow(?![a-zA-Z])/g, '=>'],
    [/\\implies(?![a-zA-Z])/g, '=>'],
    [/\\Leftrightarrow(?![a-zA-Z])/g, '<=>'],
    [/\\iff(?![a-zA-Z])/g, '<=>'],
    [/\\rightarrow(?![a-zA-Z])/g, '->'],
    [/\\leftarrow(?![a-zA-Z])/g, '<-'],
    [/\\leftrightarrow(?![a-zA-Z])/g, '<->'],
    [/\\uparrow(?![a-zA-Z])/g, 'arrow.t'],
    [/\\downarrow(?![a-zA-Z])/g, 'arrow.b'],
    [/\\forall(?![a-zA-Z])/g, 'forall'],
    [/\\exists(?![a-zA-Z])/g, 'exists'],
    [/\\nexists(?![a-zA-Z])/g, 'exists.not'],
    [/\\nabla(?![a-zA-Z])/g, 'nabla'],
    [/\\partial(?![a-zA-Z])/g, 'partial'],
    [/\\ell(?![a-zA-Z])/g, 'ell'],
    [/\\hbar(?![a-zA-Z])/g, 'planck.reduce'],
    [/\\cdot(?![a-zA-Z])/g, 'dot'],
    [/\\times(?![a-zA-Z])/g, 'times'],
    [/\\div(?![a-zA-Z])/g, 'div'],
    [/\\pm(?![a-zA-Z])/g, 'plus.minus'],
    [/\\mp(?![a-zA-Z])/g, 'minus.plus'],
    [/\\circ(?![a-zA-Z])/g, 'compose'],
    [/\\bullet(?![a-zA-Z])/g, 'bullet'],
    [/\\oplus(?![a-zA-Z])/g, 'plus.o'],
    [/\\otimes(?![a-zA-Z])/g, 'times.o'],
    [/\\ldots(?![a-zA-Z])/g, 'dots'],
    [/\\cdots(?![a-zA-Z])/g, 'dots.h'],
    [/\\vdots(?![a-zA-Z])/g, 'dots.v'],
    [/\\ddots(?![a-zA-Z])/g, 'dots.down'],
    [/\\left(?![a-zA-Z])/g, ''],
    [/\\right(?![a-zA-Z])/g, ''],
    [/\\big(?![a-zA-Z])/g, ''],
    [/\\Big(?![a-zA-Z])/g, ''],
    [/\\bigg(?![a-zA-Z])/g, ''],
    [/\\Bigg(?![a-zA-Z])/g, ''],
    [/\\quad(?![a-zA-Z])/g, ' quad '],
    [/\\qquad(?![a-zA-Z])/g, ' qquad '],
    [/\\,/g, ' '],
    [/\\:/g, ' '],
    [/\\;/g, ' '],
    [/\\!/g, ''],
    [/\\sum(?![a-zA-Z])/g, 'sum'],
    [/\\prod(?![a-zA-Z])/g, 'product'],
    [/\\coprod(?![a-zA-Z])/g, 'product.co'],
    [/\\int(?![a-zA-Z])/g, 'integral'],
    [/\\iint(?![a-zA-Z])/g, 'integral.double'],
    [/\\iiint(?![a-zA-Z])/g, 'integral.triple'],
    [/\\oint(?![a-zA-Z])/g, 'integral.cont'],
    [/\\lim(?![a-zA-Z])/g, 'lim'],
    [/\\liminf(?![a-zA-Z])/g, 'liminf'],
    [/\\limsup(?![a-zA-Z])/g, 'limsup'],
    [/\\varepsilon(?![a-zA-Z])/g, 'epsilon'],
    [/\\varphi(?![a-zA-Z])/g, 'phi'],
    [/\\vartheta(?![a-zA-Z])/g, 'theta'],
    [/\\varrho(?![a-zA-Z])/g, 'rho'],
    [/\\varsigma(?![a-zA-Z])/g, 'sigma'],
    [/\\alpha(?![a-zA-Z])/g, 'alpha'],
    [/\\beta(?![a-zA-Z])/g, 'beta'],
    [/\\gamma(?![a-zA-Z])/g, 'gamma'],
    [/\\delta(?![a-zA-Z])/g, 'delta'],
    [/\\epsilon(?![a-zA-Z])/g, 'epsilon'],
    [/\\zeta(?![a-zA-Z])/g, 'zeta'],
    [/\\eta(?![a-zA-Z])/g, 'eta'],
    [/\\theta(?![a-zA-Z])/g, 'theta'],
    [/\\iota(?![a-zA-Z])/g, 'iota'],
    [/\\kappa(?![a-zA-Z])/g, 'kappa'],
    [/\\lambda(?![a-zA-Z])/g, 'lambda'],
    [/\\mu(?![a-zA-Z])/g, 'mu'],
    [/\\nu(?![a-zA-Z])/g, 'nu'],
    [/\\xi(?![a-zA-Z])/g, 'xi'],
    [/\\pi(?![a-zA-Z])/g, 'pi'],
    [/\\rho(?![a-zA-Z])/g, 'rho'],
    [/\\sigma(?![a-zA-Z])/g, 'sigma'],
    [/\\tau(?![a-zA-Z])/g, 'tau'],
    [/\\upsilon(?![a-zA-Z])/g, 'upsilon'],
    [/\\phi(?![a-zA-Z])/g, 'phi'],
    [/\\chi(?![a-zA-Z])/g, 'chi'],
    [/\\psi(?![a-zA-Z])/g, 'psi'],
    [/\\omega(?![a-zA-Z])/g, 'omega'],
    [/\\Gamma(?![a-zA-Z])/g, 'Gamma'],
    [/\\Delta(?![a-zA-Z])/g, 'Delta'],
    [/\\Theta(?![a-zA-Z])/g, 'Theta'],
    [/\\Lambda(?![a-zA-Z])/g, 'Lambda'],
    [/\\Xi(?![a-zA-Z])/g, 'Xi'],
    [/\\Pi(?![a-zA-Z])/g, 'Pi'],
    [/\\Sigma(?![a-zA-Z])/g, 'Sigma'],
    [/\\Upsilon(?![a-zA-Z])/g, 'Upsilon'],
    [/\\Phi(?![a-zA-Z])/g, 'Phi'],
    [/\\Psi(?![a-zA-Z])/g, 'Psi'],
    [/\\Omega(?![a-zA-Z])/g, 'Omega'],
    [/\\mathbb\{R\}/g, 'bb(R)'],
    [/\\mathbb\{C\}/g, 'bb(C)'],
    [/\\mathbb\{N\}/g, 'bb(N)'],
    [/\\mathbb\{Z\}/g, 'bb(Z)'],
    [/\\mathbb\{Q\}/g, 'bb(Q)'],
    [/\\mathbb\{F\}/g, 'bb(F)'],
    [/\\mathcal\{F\}/g, 'cal(F)'],
    [/\\mathcal\{L\}/g, 'cal(L)'],
    [/\\mathcal\{B\}/g, 'cal(B)'],
    [/\\mathcal\{H\}/g, 'cal(H)'],
    [/\\mathcal\{M\}/g, 'cal(M)'],
    [/\\mathcal\{P\}/g, 'cal(P)'],
    [/\\mathcal\{O\}/g, 'cal(O)'],
    [/\\mathcal\{U\}/g, 'cal(U)'],
  ];

  for (const [pattern, replacement] of replacements) {
    text = text.replace(pattern, replacement);
  }

  text = replaceBracedCmd(text, 'overline', a => `overline(${a})`);
  text = replaceBracedCmd(text, 'underline', a => `underline(${a})`);
  text = replaceBracedCmd(text, 'widehat', a => `hat(${a})`);
  text = replaceBracedCmd(text, 'widetilde', a => `tilde(${a})`);
  text = replaceBracedCmd(text, 'hat', a => `hat(${a})`);
  text = replaceBracedCmd(text, 'tilde', a => `tilde(${a})`);
  text = replaceBracedCmd(text, 'bar', a => `overline(${a})`);
  text = replaceBracedCmd(text, 'vec', a => `arrow(${a})`);
  text = replaceBracedCmd(text, 'dot', a => `dot(${a})`);
  text = replaceBracedCmd(text, 'ddot', a => `dot.double(${a})`);
  text = replaceBracedCmd(text, 'sqrt', a => `sqrt(${a})`);
  text = replaceBracedCmd2(text, 'frac', (a, b) => `(${a}) / (${b})`);

  return text;
}

function convertDifferential(text) {
  text = text.replace(/rm\("d"\)\s*([a-zA-Z])/g, 'dif $1');
  text = text.replace(/\\mathrm\{d\}\s*([a-zA-Z])/g, 'dif $1');
  return text;
}

function convertBraceGroups(text) {
  let prev;
  do {
    prev = text;
    let result = '';
    let i = 0;
    while (i < text.length) {
      if ((text[i] === '_' || text[i] === '^') && i + 1 < text.length && text[i + 1] === '{') {
        const op = text[i];
        const end = findMatchingBrace(text, i + 1);
        if (end !== -1) {
          const inner = text.substring(i + 2, end);
          result += op + '(' + inner + ')';
          i = end + 1;
        } else {
          result += text[i];
          i++;
        }
      } else {
        result += text[i];
        i++;
      }
    }
    text = result;
  } while (text !== prev);
  return text;
}

function cleanup(text) {
  text = text.replace(/\n{4,}/g, '\n\n\n');
  text = text.replace(/[ \t]+$/gm, '');
  return text;
}

// ===========================================================================
// Main pipeline
// ===========================================================================

function convert(text, { skipSymbols = false, envOnly = false } = {}) {
  text = convertComments(text);

  if (envOnly) {
    text = convertHeadings(text);
    text = convertLeftbar(text);
    text = convertTheoremEnvs(text);
    text = convertProof(text);
    text = convertSolution(text);
    text = convertLists(text);
    text = convertMathEnvs(text);
    text = convertFigure(text);
    text = convertLabelsAndRefs(text);
    return cleanup(text);
  }

  text = convertHeadings(text);
  text = convertLeftbar(text);
  text = convertTheoremEnvs(text);
  text = convertProof(text);
  text = convertSolution(text);
  text = convertLists(text);
  text = convertMathEnvs(text);
  text = convertFigure(text);
  text = convertTableEnv(text);
  text = convertLabelsAndRefs(text);
  text = convertTextFormat(text);
  text = convertVspace(text);
  text = convertMathFonts(text);
  text = convertMathFunctions(text);
  text = convertMiscCommands(text);

  if (!skipSymbols) {
    text = convertSymbols(text);
    text = convertDifferential(text);
  }

  text = convertBraceGroups(text);
  return cleanup(text);
}

// ===========================================================================
// CLI
// ===========================================================================

const args = process.argv.slice(2);
const flags = {
  dryRun: args.includes('--dry-run'),
  envOnly: args.includes('--env-only'),
  noSymbols: args.includes('--no-symbols'),
};
const positional = args.filter(a => !a.startsWith('--'));

if (positional.length < 2) {
  console.log(`LaTeX to Typst Migration Tool (MathRepo)

Usage:
  bun migrate.js input.tex output.typ              Full conversion
  bun migrate.js input.tex output.typ --dry-run    Preview only (stdout)
  bun migrate.js input.tex output.typ --env-only   Structure + environments only
  bun migrate.js input.tex output.typ --no-symbols Skip symbol replacement`);
  process.exit(1);
}

const [inputPath, outputPath] = positional;
const latex = fs.readFileSync(inputPath, 'utf-8');
const typst = convert(latex, { skipSymbols: flags.noSymbols, envOnly: flags.envOnly });

if (flags.dryRun) {
  process.stdout.write(typst);
} else {
  fs.writeFileSync(outputPath, typst, 'utf-8');
  console.log(`Converted: ${inputPath} -> ${outputPath}`);
}
