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
  return text.replace(re, (_, title, body) => `== ${title}\n${body.trim()}`);
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
  text = text.replace(/\\Re\b/g, 'Re');
  text = text.replace(/\\Im\b/g, 'Im');
  text = replaceBracedCmd(text, 'mathrm', c => {
    if (c === 'Re') return 'Re';
    if (c === 'Im') return 'Im';
    if (c === 'Arg') return 'Arg';
    if (c === 'i') return 'i';
    if (c === 'd') return 'd';
    if (c === 'e') return 'e';
    return `\\rm("${c}")`;
  });

  const funcs = ['ln', 'exp', 'sin', 'cos', 'tan', 'cot', 'sec', 'csc',
    'arcsin', 'arccos', 'arctan', 'sinh', 'cosh', 'tanh',
    'log', 'lim', 'sup', 'inf', 'max', 'min', 'det', 'dim',
    'ker', 'deg', 'gcd', 'hom', 'arg'];
  for (const f of funcs) {
    text = text.replace(new RegExp('\\\\' + f + '\\b', 'g'), f);
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
    [/\\infty\b/g, 'oo'],
    [/\\varnothing\b/g, 'emptyset'],
    [/\\cup\b/g, 'union'],
    [/\\cap\b/g, 'inter'],
    [/\\bigcup\b/g, 'union'],
    [/\\bigcap\b/g, 'inter'],
    [/\\land\b/g, 'and'],
    [/\\lor\b/g, 'or'],
    [/\\lnot\b/g, 'not'],
    [/\\neg\b/g, 'not'],
    [/\\subseteq\b/g, 'subset.eq'],
    [/\\supseteq\b/g, 'supset.eq'],
    [/\\subsetneq\b/g, 'subset.neq'],
    [/\\supsetneq\b/g, 'supset.neq'],
    [/\\subset\b/g, 'subset'],
    [/\\supset\b/g, 'supset'],
    [/\\setminus\b/g, 'backslash'],
    [/\\in\b/g, 'in'],
    [/\\notin\b/g, 'in.not'],
    [/\\neq\b/g, '!='],
    [/\\leq\b/g, '<='],
    [/\\geq\b/g, '>='],
    [/\\ll\b/g, '<<'],
    [/\\gg\b/g, '>>'],
    [/\\approx\b/g, 'approx'],
    [/\\equiv\b/g, 'equiv'],
    [/\\sim\b/g, '~'],
    [/\\simeq\b/g, 'tilde.eq'],
    [/\\propto\b/g, 'prop'],
    [/\\to\b/g, '->'],
    [/\\mapsto\b/g, '|->'],
    [/\\longrightarrow\b/g, '->'],
    [/\\longleftarrow\b/g, '<-'],
    [/\\Rightarrow\b/g, '=>'],
    [/\\implies\b/g, '=>'],
    [/\\Leftrightarrow\b/g, '<=>'],
    [/\\iff\b/g, '<=>'],
    [/\\rightarrow\b/g, '->'],
    [/\\leftarrow\b/g, '<-'],
    [/\\leftrightarrow\b/g, '<->'],
    [/\\uparrow\b/g, 'arrow.t'],
    [/\\downarrow\b/g, 'arrow.b'],
    [/\\forall\b/g, 'forall'],
    [/\\exists\b/g, 'exists'],
    [/\\nexists\b/g, 'exists.not'],
    [/\\nabla\b/g, 'nabla'],
    [/\\partial\b/g, 'partial'],
    [/\\ell\b/g, 'ell'],
    [/\\hbar\b/g, 'planck.reduce'],
    [/\\cdot\b/g, 'dot'],
    [/\\times\b/g, 'times'],
    [/\\div\b/g, 'div'],
    [/\\pm\b/g, 'plus.minus'],
    [/\\mp\b/g, 'minus.plus'],
    [/\\circ\b/g, 'compose'],
    [/\\bullet\b/g, 'bullet'],
    [/\\oplus\b/g, 'plus.o'],
    [/\\otimes\b/g, 'times.o'],
    [/\\ldots\b/g, 'dots'],
    [/\\cdots\b/g, 'dots.h'],
    [/\\vdots\b/g, 'dots.v'],
    [/\\ddots\b/g, 'dots.down'],
    [/\\left\b/g, ''],
    [/\\right\b/g, ''],
    [/\\big\b(?![gG])/g, ''],
    [/\\Big\b(?![gG])/g, ''],
    [/\\bigg\b(?![G])/g, ''],
    [/\\Bigg\b/g, ''],
    [/\\quad\b/g, ' quad '],
    [/\\qquad\b/g, ' qquad '],
    [/\\,/g, ' '],
    [/\\:/g, ' '],
    [/\\;/g, ' '],
    [/\\!/g, ''],
    [/\\sum\b/g, 'sum'],
    [/\\prod\b/g, 'product'],
    [/\\coprod\b/g, 'product.co'],
    [/\\int\b/g, 'integral'],
    [/\\iint\b/g, 'integral.double'],
    [/\\iiint\b/g, 'integral.triple'],
    [/\\oint\b/g, 'integral.cont'],
    [/\\lim\b/g, 'lim'],
    [/\\liminf\b/g, 'liminf'],
    [/\\limsup\b/g, 'limsup'],
    [/\\varepsilon\b/g, 'epsilon'],
    [/\\varphi\b/g, 'phi'],
    [/\\vartheta\b/g, 'theta'],
    [/\\varrho\b/g, 'rho'],
    [/\\varsigma\b/g, 'sigma'],
    [/\\alpha\b/g, 'alpha'],
    [/\\beta\b/g, 'beta'],
    [/\\gamma\b/g, 'gamma'],
    [/\\delta\b/g, 'delta'],
    [/\\epsilon\b/g, 'epsilon'],
    [/\\zeta\b/g, 'zeta'],
    [/\\eta\b/g, 'eta'],
    [/\\theta\b/g, 'theta'],
    [/\\iota\b/g, 'iota'],
    [/\\kappa\b/g, 'kappa'],
    [/\\lambda\b/g, 'lambda'],
    [/\\mu\b/g, 'mu'],
    [/\\nu\b/g, 'nu'],
    [/\\xi\b/g, 'xi'],
    [/\\pi\b/g, 'pi'],
    [/\\rho\b/g, 'rho'],
    [/\\sigma\b/g, 'sigma'],
    [/\\tau\b/g, 'tau'],
    [/\\upsilon\b/g, 'upsilon'],
    [/\\phi\b/g, 'phi'],
    [/\\chi\b/g, 'chi'],
    [/\\psi\b/g, 'psi'],
    [/\\omega\b/g, 'omega'],
    [/\\Gamma\b/g, 'Gamma'],
    [/\\Delta\b/g, 'Delta'],
    [/\\Theta\b/g, 'Theta'],
    [/\\Lambda\b/g, 'Lambda'],
    [/\\Xi\b/g, 'Xi'],
    [/\\Pi\b/g, 'Pi'],
    [/\\Sigma\b/g, 'Sigma'],
    [/\\Upsilon\b/g, 'Upsilon'],
    [/\\Phi\b/g, 'Phi'],
    [/\\Psi\b/g, 'Psi'],
    [/\\Omega\b/g, 'Omega'],
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
