#!/usr/bin/env python3
"""
LaTeX to Typst Migration Tool — MathRepo

Mechanical batch conversion for migrating LaTeX (elegantbook) notes to Typst.
Handles: headings, environments, symbols, labels, references, font commands, lists.

Usage:
  python migrate.py input.tex output.typ              # full conversion
  python migrate.py input.tex output.typ --dry-run    # preview without writing
  python migrate.py input.tex output.typ --env-only   # environments + structure only
  python migrate.py input.tex output.typ --no-symbols # skip math symbol replacement

Requires: Python 3.7+ (stdlib only, no pip packages).
"""

import re
import sys
import argparse


# ===========================================================================
# Helper functions
# ===========================================================================

def find_matching_brace(text, start):
    """Find matching } for { at position start. Returns index of } or -1."""
    if start >= len(text) or text[start] != '{':
        return -1
    depth = 0
    i = start
    while i < len(text):
        if text[i] == '{':
            depth += 1
        elif text[i] == '}':
            depth -= 1
            if depth == 0:
                return i
        i += 1
    return -1


def extract_braced_arg(text, pos):
    """Extract {content} starting at pos. Returns (content, end_pos) or (None, pos)."""
    if pos >= len(text) or text[pos] != '{':
        return None, pos
    end = find_matching_brace(text, pos)
    if end == -1:
        return None, pos
    return text[pos + 1:end], end + 1


def is_math_mode_around(text, match_start, match_end):
    """
    Heuristic: check if position is likely inside math mode.
    Counts unescaped $ before the position; odd = inside inline math.
    Also checks for display math delimiters.
    """
    before = text[:match_start]
    dollar_count = 0
    i = 0
    while i < len(before):
        if before[i] == '\\' and i + 1 < len(before) and before[i + 1] == '$':
            i += 2
            continue
        if before[i] == '$':
            dollar_count += 1
        i += 1
    if dollar_count % 2 == 1:
        return True
    if re.search(r'\$\$[^$]*$', before) or re.search(r'\$\s*$', before, re.MULTILINE):
        return True
    return False


# ===========================================================================
# Environment helpers
# ===========================================================================

def find_env(text, env_name):
    """
    Find first \\begin{env_name} in text.
    Returns (body, full_match, end_pos) or None.
    body = content between \\begin and \\end (with leading arg stripped).
    full_match = entire \\begin{env}...\\end{env} string.
    """
    pattern = re.compile(r'\\begin\{' + re.escape(env_name) + r'\}')
    m = pattern.search(text)
    if not m:
        return None

    env_start = m.start()
    after_begin = m.end()

    body_start = after_begin
    if after_begin < len(text) and text[after_begin] == '{':
        end = find_matching_brace(text, after_begin)
        if end != -1:
            body_start = end + 1

    end_pattern = re.compile(r'\\end\{' + re.escape(env_name) + r'\}')
    end_m = end_pattern.search(text, body_start)
    if not end_m:
        return None

    body = text[body_start:end_m.start()]
    full_match = text[env_start:end_m.end()]
    return body, full_match, end_m.end()


def replace_all_envs(text, env_name, replacer):
    """
    Replace all occurrences of \\begin{env_name}...\\end{env_name}.
    replacer(body, full_match) -> replacement string.
    Iterates until no more matches (handles multiple occurrences safely).
    """
    max_iter = 200
    for _ in range(max_iter):
        result = find_env(text, env_name)
        if result is None:
            break
        body, full_match, end_pos = result
        replacement = replacer(body, full_match)
        text = text[:result[0] if False else text.index(full_match)] + replacement + text[end_pos:]
    return text


def replace_all_envs_safe(text, env_name, replacer):
    """
    Safe version: finds all environments first, then replaces from end to start
    to preserve positions.
    """
    pattern = re.compile(r'\\begin\{' + re.escape(env_name) + r'\}')
    end_pattern = re.compile(r'\\end\{' + re.escape(env_name) + r'\}')

    matches = []
    search_start = 0
    while True:
        m = pattern.search(text, search_start)
        if not m:
            break

        after_begin = m.end()
        body_start = after_begin
        if after_begin < len(text) and text[after_begin] == '{':
            end = find_matching_brace(text, after_begin)
            if end != -1:
                body_start = end + 1

        end_m = end_pattern.search(text, body_start)
        if not end_m:
            search_start = m.end()
            continue

        body = text[body_start:end_m.start()]
        matches.append((m.start(), end_m.end(), body, m.start()))
        search_start = end_m.end()

    for start, end, body, orig_start in reversed(matches):
        replacement = replacer(body, text[start:end])
        text = text[:start] + replacement + text[end:]

    return text


# ===========================================================================
# Conversion functions
# ===========================================================================

def convert_comments(text):
    """Remove LaTeX comments (lines starting with %, or inline % comments).
    Preserves escaped \\%."""
    lines = text.split('\n')
    result = []
    for line in lines:
        new_line = []
        i = 0
        while i < len(line):
            if line[i] == '%' and (i == 0 or line[i - 1] != '\\'):
                break
            new_line.append(line[i])
            i += 1
        result.append(''.join(new_line))
    return '\n'.join(result)


def convert_headings(text):
    """\\part, \\chapter, \\section, \\subsection, \\subsubsection, \\paragraph."""
    text = re.sub(r'\\part\{([^}]*)\}', r'#part("\1")', text)
    text = re.sub(r'\\chapter\{([^}]*)\}', r'= \1', text)
    text = re.sub(r'\\section\{([^}]*)\}', r'== \1', text)
    text = re.sub(r'\\subsection\{([^}]*)\}', r'=== \1', text)
    text = re.sub(r'\\subsubsection\{([^}]*)\}', r'==== \1', text)
    text = re.sub(r'\\paragraph\{([^}]*)\}', r'*\1*', text)
    return text


def convert_labels_and_refs(text):
    """\\label, \\ref, \\eqref, \\eq, \\begin{equation}."""
    text = re.sub(r'\\label\{([^}]*)\}', r'<\1>', text)
    text = re.sub(r'\\eqref\{([^}]*)\}', r'@eq:\1', text)
    text = re.sub(r'\\ref\{([^}]*)\}', r'@\1', text)
    text = re.sub(r'\\begin\{equation\}', '$', text)
    text = re.sub(r'\\end\{equation\}', '$', text)
    return text


def convert_leftbar(text):
    """\\begin{leftbarTitle}{Title}...\\end{leftbarTitle} -> == Title (subsection heading)."""
    def replacer(body, full_match):
        m = re.match(r'\s*\{([^}]*)\}\s*', full_match)
        if m:
            title = m.group(1)
            return f'== {title}\n{body}'
        return f'== Unknown Title\n{body}'

    pattern = re.compile(
        r'\\begin\{leftbarTitle\}\{([^}]*)\}\s*(.*?)\\end\{leftbarTitle\}',
        re.DOTALL
    )
    text = pattern.sub(lambda m: f'== {m.group(1)}\n{m.group(2).strip()}', text)
    return text


def convert_theorem_envs(text):
    """
    Theorem-like environments -> Typst components.
    Handles both \\begin{theorem}[Name] and \\begin{definition}{Name}.
    """
    envs = [
        'theorem', 'corollary', 'lemma',
        'definition', 'property',
        'proposition', 'example',
        'axiom', 'postulate',
        'exercise', 'problem',
        'remark', 'note',
    ]

    component_map = {
        'theorem': 'theorem', 'corollary': 'corollary', 'lemma': 'lemma',
        'definition': 'definition', 'property': 'property',
        'proposition': 'proposition', 'example': 'example',
        'axiom': 'axiom', 'postulate': 'postulate',
        'exercise': 'exercise', 'problem': 'example',
        'remark': 'note', 'note': 'note',
    }

    for env in envs:
        component = component_map[env]

        def make_replacer(comp):
            def replacer(body, full_match):
                name = ''
                begin_pattern = re.compile(r'\\begin\{' + re.escape(env) + r'\}')
                bm = begin_pattern.search(full_match)
                if bm:
                    after = bm.end()
                    if after < len(full_match) and full_match[after] == '{':
                        end = find_matching_brace(full_match, after)
                        if end != -1:
                            name = full_match[after + 1:end]
                    elif after < len(full_match) and full_match[after] == '[':
                        bracket_end = full_match.index(']', after) if ']' in full_match[after:] else -1
                        if bracket_end != -1:
                            name = full_match[after + 1:bracket_end]

                body = body.strip()
                if name:
                    return f'#{comp}(name: "{name}")[\n{body}\n]'
                else:
                    return f'#{comp}[\n{body}\n]'
            return replacer

        text = replace_all_envs_safe(text, env, replacer)

    return text


def convert_proof(text):
    """\\begin{proof}...\\end{proof} -> #proof[...]."""
    def replacer(body, full_match):
        body = body.strip()
        body = re.sub(r'\s*\\qeds*\s*$', '', body)
        body = re.sub(r'\s*\\qed\s*$', '', body)
        return f'#proof[\n{body}\n]'

    text = replace_all_envs_safe(text, 'proof', replacer)
    return text


def convert_solution(text):
    """\\begin{solution}...\\end{solution} -> #solution[...]."""
    def replacer(body, full_match):
        return f'#solution[\n{body.strip()}\n]'

    text = replace_all_envs_safe(text, 'solution', replacer)
    return text


def convert_lists(text):
    """\\begin{enumerate/itemize/description} -> Typst lists."""
    def replacer_enumerate(body, full_match):
        items = re.split(r'\\item\s+', body)
        result = []
        for item in items:
            item = item.strip()
            if item:
                result.append(f'1. {item}')
        return '\n\n'.join(result)

    def replacer_itemize(body, full_match):
        items = re.split(r'\\item\s+', body)
        result = []
        for item in items:
            item = item.strip()
            if item:
                result.append(f'- {item}')
        return '\n\n'.join(result)

    def replacer_description(body, full_match):
        items = re.split(r'\\item\s*', body)
        result = []
        idx = 1
        for item in items:
            item = item.strip()
            if not item:
                continue
            label_m = re.match(r'\[([^\]]*)\]\s*(.*)', item, re.DOTALL)
            if label_m:
                label = label_m.group(1).strip()
                content = label_m.group(2).strip()
                result.append(f'{idx}. *{label}.* {content}')
            else:
                result.append(f'{idx}. {item}')
            idx += 1
        return '\n\n'.join(result)

    text = replace_all_envs_safe(text, 'enumerate', replacer_enumerate)
    text = replace_all_envs_safe(text, 'itemize', replacer_itemize)
    text = replace_all_envs_safe(text, 'description', replacer_description)
    return text


def convert_math_environments(text):
    """align*, gather*, equation*, \\[...\\], \\(...\\) -> Typst display/inline math."""
    def replacer_align(body, full_match):
        body = re.sub(r'\\(?:notag|nonumber)\*?\s*', '', body)
        body = re.sub(r'\\label\{([^}]*)\}', r'<eq:\1>', body)
        body = body.strip()
        return f'$\n{body}\n$'

    def replacer_gather(body, full_match):
        body = re.sub(r'\\(?:notag|nonumber)\*?\s*', '', body)
        body = body.strip()
        parts = re.split(r'\\\\', body)
        return '\n\n'.join(f'$\n{p.strip()}\n$' for p in parts if p.strip())

    text = replace_all_envs_safe(text, 'align*', replacer_align)
    text = replace_all_envs_safe(text, 'align', replacer_align)
    text = replace_all_envs_safe(text, 'gather*', replacer_gather)
    text = replace_all_envs_safe(text, 'gather', replacer_gather)
    text = replace_all_envs_safe(text, 'equation*', replacer_align)

    text = re.sub(r'\\\[(.+?)\\\]', lambda m: f'$\n{m.group(1).strip()}\n$', text, flags=re.DOTALL)
    text = re.sub(r'\\\((.+?)\\\)', lambda m: f'${m.group(1).strip()}$', text)

    return text


def convert_figure(text):
    """\\begin{figure}...\\end{figure} -> #figure(...)."""
    def replacer(body, full_match):
        caption_m = re.search(r'\\caption\{([^}]*)\}', body)
        label_m = re.search(r'\\label\{([^}]*)\}', body)
        includegraphics_m = re.search(
            r'\\includegraphics(?:\[([^\]]*)\])?\{([^}]*)\}', body
        )

        caption = caption_m.group(1) if caption_m else ''
        label = label_m.group(1) if label_m else ''
        img_path = includegraphics_m.group(2) if includegraphics_m else ''
        options = includegraphics_m.group(1) if includegraphics_m and includegraphics_m.group(1) else ''

        width = ''
        if options:
            w_m = re.search(r'width\s*=\s*([^,]+)', options)
            if w_m:
                width = w_m.group(1).strip()

        lines = ['#figure(']
        if img_path:
            if width:
                lines.append(f'  image("{img_path}", width: {width}),')
            else:
                lines.append(f'  image("{img_path}", width: 60%),')
        if caption:
            lines.append(f'  caption: [{caption}],')
        lines.append('  placement: auto,')
        lines.append('  supplement: [Fig.],')
        lines.append(')')
        if label:
            lines.append(f'<{label}>')

        return '\n'.join(lines)

    text = replace_all_envs_safe(text, 'figure', replacer)
    return text


def convert_table_env(text):
    """\\begin{table}...\\end{table} -> #tex-table(...) (basic conversion)."""
    def replacer(body, full_match):
        caption_m = re.search(r'\\caption\{([^}]*)\}', body)
        label_m = re.search(r'\\label\{([^}]*)\}', body)
        caption = caption_m.group(1) if caption_m else ''
        label = label_m.group(1) if label_m else ''

        lines = []
        if caption:
            lines.append(f'// Table: {caption}')
        lines.append('// TODO: Convert tabular environment to #tex-table(...)')
        lines.append(f'// Original tabular content:')
        tabular_m = re.search(r'\\begin\{tabular\}[^}]*\}(.*?)\\end\{tabular\}', body, re.DOTALL)
        if tabular_m:
            for row_line in tabular_m.group(1).strip().split('\n'):
                lines.append(f'//   {row_line.strip()}')
        if label:
            lines.append(f'<{label}>')

        return '\n'.join(lines)

    text = replace_all_envs_safe(text, 'table', replacer)
    return text


def convert_text_format(text):
    """\\textbf, \\textit, \\textrm, \\text, \\emph."""
    def textbf_replacer(m):
        content = m.group(1)
        return f'*{content}*'

    def textit_replacer(m):
        content = m.group(1)
        return f'_{content}_'

    def emph_replacer(m):
        content = m.group(1)
        return f'_{content}_'

    def textrm_replacer(m):
        content = m.group(1)
        return f'rm("{content}")'

    def text_replacer(m):
        content = m.group(1)
        return f'text("{content}")'

    text = re.sub(r'\\textbf\{([^{}]*)\}', textbf_replacer, text)
    text = re.sub(r'\\textit\{([^{}]*)\}', textit_replacer, text)
    text = re.sub(r'\\emph\{([^{}]*)\}', emph_replacer, text)
    text = re.sub(r'\\textrm\{([^{}]*)\}', textrm_replacer, text)
    text = re.sub(r'\\text\{([^{}]*)\}', text_replacer, text)

    return text


def convert_vspace(text):
    """\\vspace{...} -> #v(...)."""
    text = re.sub(r'\\vspace\{([^}]*)\}', r'#v(\1)', text)
    return text


def convert_math_fonts(text):
    """\\mathbb, \\mathcal, \\mathscr, \\mathfrak."""
    text = re.sub(r'\\mathbb\{([^{}]*)\}', r'bb(\1)', text)
    text = re.sub(r'\\mathcal\{([^{}]*)\}', r'cal(\1)', text)
    text = re.sub(r'\\mathscr\{([^{}]*)\}', r'scr(\1)', text)
    text = re.sub(r'\\mathfrak\{([^{}]*)\}', r'frak(\1)', text)
    return text


def convert_math_functions(text):
    """\\mathrm, \\operatorname, \\ln, \\exp, trig functions, etc."""
    text = re.sub(r'\\operatorname\{([^{}]*)\}', lambda m: f'"{m.group(1)}"', text)

    text = re.sub(r'\\Re\b', 'Re', text)
    text = re.sub(r'\\Im\b', 'Im', text)

    text = re.sub(r'\\mathrm\{([^{}]*)\}', lambda m: f'rm("{m.group(1)}")', text)

    for func in ['ln', 'exp', 'sin', 'cos', 'tan', 'cot', 'sec', 'csc',
                 'arcsin', 'arccos', 'arctan', 'sinh', 'cosh', 'tanh',
                 'log', 'lim', 'sup', 'inf', 'max', 'min', 'det', 'dim',
                 'ker', 'deg', 'gcd', 'hom', 'arg']:
        text = re.sub(r'\\' + func + r'\b', func, text)

    text = re.sub(r'\\operatorname\{([^{}]*)\}', lambda m: f'"{m.group(1)}"', text)

    return text


def convert_misc_commands(text):
    """\\noindent, \\centering, size declarations, \\hspace, etc."""
    text = re.sub(r'\\noindent\s*', '', text)
    text = re.sub(r'\\centering\s*', '', text)
    text = re.sub(r'\\(?:tiny|scriptsize|footnotesize|small|normalsize|large|Large|LARGE|huge|Huge)\s*', '', text)
    text = re.sub(r'\\hspace\{[^}]*\}', '', text)
    text = re.sub(r'\\bigskip\s*', '\n', text)
    text = re.sub(r'\\medskip\s*', '\n', text)
    text = re.sub(r'\\smallskip\s*', '\n', text)
    text = re.sub(r'\\newline\s*', '\n', text)
    text = re.sub(r'\\linebreak\s*', '\n', text)
    text = re.sub(r'\\pagebreak\s*', '', text)
    text = re.sub(r'\\clearpage\s*', '', text)
    text = re.sub(r'\\newpage\s*', '', text)
    text = re.sub(r'\\\\\[([^\]]*)\]', '', text)
    return text


def convert_symbols(text):
    """LaTeX math symbols -> Typst equivalents."""
    replacements = [
        (r'\\infty\b', 'oo'),
        (r'\\varnothing\b', 'emptyset'),

        (r'\\cup\b', 'union'),
        (r'\\cap\b', 'inter'),
        (r'\\bigcup\b', 'union'),
        (r'\\bigcap\b', 'inter'),

        (r'\\land\b', 'and'),
        (r'\\lor\b', 'or'),
        (r'\\lnot\b', 'not'),
        (r'\\neg\b', 'not'),

        (r'\\subseteq\b', 'subset.eq'),
        (r'\\supseteq\b', 'supset.eq'),
        (r'\\subsetneq\b', 'subset.neq'),
        (r'\\supsetneq\b', 'supset.neq'),
        (r'\\subset\b', 'subset'),
        (r'\\supset\b', 'supset'),

        (r'\\setminus\b', 'backslash'),

        (r'\\in\b', 'in'),
        (r'\\notin\b', 'in.not'),

        (r'\\neq\b', '!='),
        (r'\\leq\b', '<='),
        (r'\\geq\b', '>='),
        (r'\\ll\b', '<<'),
        (r'\\gg\b', '>>'),
        (r'\\approx\b', 'approx'),
        (r'\\equiv\b', 'equiv'),
        (r'\\sim\b', '~'),
        (r'\\simeq\b', 'tilde.eq'),
        (r'\\propto\b', 'prop'),

        (r'\\to\b', '->'),
        (r'\\mapsto\b', '|->'),
        (r'\\longrightarrow\b', '->'),
        (r'\\longleftarrow\b', '<-'),
        (r'\\Rightarrow\b', '=>'),
        (r'\\implies\b', '=>'),
        (r'\\Leftrightarrow\b', '<=>'),
        (r'\\iff\b', '<=>'),
        (r'\\rightarrow\b', '->'),
        (r'\\leftarrow\b', '<-'),
        (r'\\leftrightarrow\b', '<->'),
        (r'\\uparrow\b', 'arrow.t'),
        (r'\\downarrow\b', 'arrow.b'),

        (r'\\forall\b', 'forall'),
        (r'\\exists\b', 'exists'),
        (r'\\nexists\b', 'exists.not'),

        (r'\\nabla\b', 'nabla'),
        (r'\\partial\b', 'partial'),
        (r'\\ell\b', 'ell'),
        (r'\\hbar\b', 'planck.reduce'),

        (r'\\cdot\b', 'dot'),
        (r'\\times\b', 'times'),
        (r'\\div\b', 'div'),
        (r'\\pm\b', 'plus.minus'),
        (r'\\mp\b', 'minus.plus'),
        (r'\\circ\b', 'compose'),
        (r'\\bullet\b', 'bullet'),
        (r'\\oplus\b', 'plus.o'),
        (r'\\otimes\b', 'times.o'),

        (r'\\ldots\b', 'dots'),
        (r'\\cdots\b', 'dots.h'),
        (r'\\vdots\b', 'dots.v'),
        (r'\\ddots\b', 'dots.down'),

        (r'\\left\b', ''),
        (r'\\right\b', ''),
        (r'\\big\b', ''),
        (r'\\Big\b', ''),
        (r'\\bigg\b', ''),
        (r'\\Bigg\b', ''),

        (r'\\quad\b', ' quad '),
        (r'\\qquad\b', ' qquad '),
        (r'\\,', ' '),
        (r'\\:', ' '),
        (r'\\;', ' '),
        (r'\\!', ''),

        (r'\\overline\{([^{}]*)\}', r'overline(\1)'),
        (r'\\underline\{([^{}]*)\}', r'underline(\1)'),
        (r'\\hat\{([^{}]*)\}', r'hat(\1)'),
        (r'\\tilde\{([^{}]*)\}', r'tilde(\1)'),
        (r'\\bar\{([^{}]*)\}', r'overline(\1)'),
        (r'\\vec\{([^{}]*)\}', r'arrow(\1)'),
        (r'\\dot\{([^{}]*)\}', r'dot(\1)'),
        (r'\\ddot\{([^{}]*)\}', r'dot.double(\1)'),
        (r'\\widehat\{([^{}]*)\}', r'hat(\1)'),
        (r'\\widetilde\{([^{}]*)\}', r'tilde(\1)'),

        (r'\\sqrt\{([^{}]*)\}', r'sqrt(\1)'),
        (r'\\frac\{([^{}]*)\}\{([^{}]*)\}', r'(\1) / (\2)'),

        (r'\\sum\b', 'sum'),
        (r'\\prod\b', 'product'),
        (r'\\coprod\b', 'product.co'),
        (r'\\int\b', 'integral'),
        (r'\\iint\b', 'integral.double'),
        (r'\\iiint\b', 'integral.triple'),
        (r'\\oint\b', 'integral.cont'),
        (r'\\lim\b', 'lim'),
        (r'\\liminf\b', 'liminf'),
        (r'\\limsup\b', 'limsup'),

        (r'\\varepsilon\b', 'epsilon'),
        (r'\\varphi\b', 'phi'),
        (r'\\vartheta\b', 'theta'),
        (r'\\varrho\b', 'rho'),
        (r'\\varsigma\b', 'sigma'),

        (r'\\alpha\b', 'alpha'),
        (r'\\beta\b', 'beta'),
        (r'\\gamma\b', 'gamma'),
        (r'\\delta\b', 'delta'),
        (r'\\epsilon\b', 'epsilon'),
        (r'\\zeta\b', 'zeta'),
        (r'\\eta\b', 'eta'),
        (r'\\theta\b', 'theta'),
        (r'\\iota\b', 'iota'),
        (r'\\kappa\b', 'kappa'),
        (r'\\lambda\b', 'lambda'),
        (r'\\mu\b', 'mu'),
        (r'\\nu\b', 'nu'),
        (r'\\xi\b', 'xi'),
        (r'\\pi\b', 'pi'),
        (r'\\rho\b', 'rho'),
        (r'\\sigma\b', 'sigma'),
        (r'\\tau\b', 'tau'),
        (r'\\upsilon\b', 'upsilon'),
        (r'\\phi\b', 'phi'),
        (r'\\chi\b', 'chi'),
        (r'\\psi\b', 'psi'),
        (r'\\omega\b', 'omega'),

        (r'\\Gamma\b', 'Gamma'),
        (r'\\Delta\b', 'Delta'),
        (r'\\Theta\b', 'Theta'),
        (r'\\Lambda\b', 'Lambda'),
        (r'\\Xi\b', 'Xi'),
        (r'\\Pi\b', 'Pi'),
        (r'\\Sigma\b', 'Sigma'),
        (r'\\Upsilon\b', 'Upsilon'),
        (r'\\Phi\b', 'Phi'),
        (r'\\Psi\b', 'Psi'),
        (r'\\Omega\b', 'Omega'),

        (r'\\mathbb\{R\}', 'bb(R)'),
        (r'\\mathbb\{C\}', 'bb(C)'),
        (r'\\mathbb\{N\}', 'bb(N)'),
        (r'\\mathbb\{Z\}', 'bb(Z)'),
        (r'\\mathbb\{Q\}', 'bb(Q)'),
        (r'\\mathbb\{F\}', 'bb(F)'),
        (r'\\mathcal\{F\}', 'cal(F)'),
        (r'\\mathcal\{L\}', 'cal(L)'),
        (r'\\mathcal\{B\}', 'cal(B)'),
        (r'\\mathcal\{H\}', 'cal(H)'),
        (r'\\mathcal\{M\}', 'cal(M)'),
        (r'\\mathcal\{P\}', 'cal(P)'),
        (r'\\mathcal\{O\}', 'cal(O)'),
        (r'\\mathcal\{U\}', 'cal(U)'),
    ]

    for pattern, replacement in replacements:
        text = re.sub(pattern, replacement, text)

    return text


def convert_differential(text):
    """\\mathrm{d}x -> dif x (must run AFTER convert_symbols)."""
    text = re.sub(r'rm\("d"\)\s*([a-zA-Z])', r'dif \1', text)
    text = re.sub(r'\\mathrm\{d\}\s*([a-zA-Z])', r'dif \1', text)
    return text


def cleanup(text):
    """Remove excessive blank lines and trailing whitespace."""
    text = re.sub(r'\n{4,}', '\n\n\n', text)
    text = re.sub(r'[ \t]+$', '', text, flags=re.MULTILINE)
    return text


# ===========================================================================
# Main pipeline
# ===========================================================================

def convert(text, skip_symbols=False, env_only=False):
    """Full conversion pipeline."""
    text = convert_comments(text)

    if env_only:
        text = convert_headings(text)
        text = convert_leftbar(text)
        text = convert_theorem_envs(text)
        text = convert_proof(text)
        text = convert_solution(text)
        text = convert_lists(text)
        text = convert_math_environments(text)
        text = convert_figure(text)
        text = convert_labels_and_refs(text)
        text = cleanup(text)
        return text

    text = convert_headings(text)
    text = convert_leftbar(text)
    text = convert_theorem_envs(text)
    text = convert_proof(text)
    text = convert_solution(text)
    text = convert_lists(text)
    text = convert_math_environments(text)
    text = convert_figure(text)
    text = convert_table_env(text)
    text = convert_labels_and_refs(text)
    text = convert_text_format(text)
    text = convert_vspace(text)
    text = convert_math_fonts(text)
    text = convert_math_functions(text)
    text = convert_misc_commands(text)

    if not skip_symbols:
        text = convert_symbols(text)
        text = convert_differential(text)

    text = cleanup(text)
    return text


def main():
    parser = argparse.ArgumentParser(
        description='LaTeX to Typst Migration Tool (MathRepo)',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python migrate.py chap01.tex chap01.typ              Full conversion
  python migrate.py chap01.tex chap01.typ --dry-run    Preview only
  python migrate.py chap01.tex chap01.typ --env-only   Structure + environments
  python migrate.py chap01.tex chap01.typ --no-symbols Skip symbol replacement
        """
    )
    parser.add_argument('input', help='Input LaTeX file (.tex)')
    parser.add_argument('output', help='Output Typst file (.typ)')
    parser.add_argument('--dry-run', action='store_true',
                        help='Print converted output to stdout without writing file')
    parser.add_argument('--env-only', action='store_true',
                        help='Only convert headings, environments, lists, figures, labels')
    parser.add_argument('--no-symbols', action='store_true',
                        help='Skip math symbol replacement')

    args = parser.parse_args()

    with open(args.input, 'r', encoding='utf-8') as f:
        latex = f.read()

    typst = convert(latex, skip_symbols=args.no_symbols, env_only=args.env_only)

    if args.dry_run:
        print(typst)
    else:
        with open(args.output, 'w', encoding='utf-8') as f:
            f.write(typst)
        print(f'Converted: {args.input} -> {args.output}')


if __name__ == '__main__':
    main()
