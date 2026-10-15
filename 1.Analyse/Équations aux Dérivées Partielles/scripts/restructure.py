"""
Restructure Équations aux Dérivées Partielles initial.typ
from 5 Part / 19 Ch to 6 Part / 19 Ch.
"""
import re
import shutil

# Chapter mapping: old → new
CMAP = {
    1: 1, 2: 2,          # Foundations
    6: 3, 7: 4,          # Distributions
    8: 5, 9: 6, 10: 7, 11: 8,  # Elliptic
    12: 9, 13: 10, 14: 11,     # Parabolic
    3: 12, 4: 13, 5: 14,       # First-order (moved to Hyperbolic Part)
    15: 15, 16: 16, 17: 17,    # Hyperbolic
    18: 18, 19: 19,            # Methods
}

PART_ORDER = [
    ("Foundations and Classification", [1, 2]),
    ("Distribution Theory", [6, 7]),
    ("Elliptic Equations", [8, 9, 10, 11]),
    ("Parabolic Equations", [12, 13, 14]),
    ("Hyperbolic Equations and First-Order Theory", [3, 4, 5, 15, 16, 17]),
    ("Solution Methods and Numerical Methods", [18, 19]),
]

def extract_chapters(lines):
    """Extract chapters. Returns dict {old_ch: [lines]}."""
    chapters = {}
    chapter_starts = []
    
    for i, line in enumerate(lines):
        s = line.strip()
        if s.startswith('= ') and not s.startswith('== '):
            chapter_starts.append(i)
    
    for idx, start in enumerate(chapter_starts):
        old_ch = idx + 1
        # Find end: next chapter start or #part or EOF, whichever is first
        end = len(lines)
        for ns in chapter_starts[idx+1:]:
            # Check if there's a #part between start and ns
            has_part = False
            for j in range(start+1, ns):
                if lines[j].strip().startswith('#part('):
                    end = j
                    has_part = True
                    break
            if has_part:
                break
            # No #part between, so next chapter is the boundary
            end = ns
            break
        chapters[old_ch] = lines[start:end]
    
    return chapters

def ref_updates(text):
    """Update all cross-references in text."""
    for old, new in CMAP.items():
        text = re.sub(r'\[Ch ' + str(old) + r'\]', f'[Ch {new}]', text)
        for s in range(1, 8):
            text = re.sub(r'\[§' + str(old) + r'\.' + str(s) + r'\]',
                         f'[§{new}.{s}]', text)
            for k in ['Definition', 'Example', 'Theorem', 'Proposition',
                      'Lemma', 'Corollary', 'Proof']:
                text = re.sub(r'\[' + k + r' ' + str(old) + r'\.' + str(s) + r'\]',
                             f'[{k} {new}.{s}]', text)
    return text

def main():
    path = r'C:\Notiz\MathRepo\1.Analyse\Équations aux Dérivées Partielles\initial.typ'
    
    # Create backup
    backup_path = path.replace('.typ', '.typ.bak')
    shutil.copy2(path, backup_path)
    print(f"Backup created: {backup_path}")
    
    with open(path, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    chapters = extract_chapters(lines)
    
    # Find preamble (before first chapter start)
    first_start = None
    for i, line in enumerate(lines):
        s = line.strip()
        if s.startswith('= ') and not s.startswith('== '):
            first_start = i
            break
    preamble = lines[:first_start]
    
    # Find postamble (from structure note to EOF)
    post_start = None
    for i, line in enumerate(lines):
        if '结构说明' in line and line.strip().startswith('//'):
            post_start = i
            break
    postamble = lines[post_start:] if post_start else []
    
    # Strip old blueprint from preamble: find '目录蓝图' and remove up to first '#part'
    bp_start_idx = None
    for i, line in enumerate(preamble):
        if '目录蓝图' in line and line.strip().startswith('//'):
            bp_start_idx = i
            break
    
    if bp_start_idx:
        # Find where blueprint ends (before first #part)
        for i in range(bp_start_idx, len(preamble)):
            if preamble[i].strip().startswith('#part('):
                pre_bp = preamble[:bp_start_idx]
                break
        else:
            pre_bp = preamble
    else:
        pre_bp = preamble
    
    # Build new content
    out = pre_bp[:]  # Cover, outline, imports
    
    # Write new blueprint
    out.append('''
// ==========================================================================
// 目录蓝图 (Planned Outline)
// ==========================================================================
// 主线：语言框架 → 分布工具 → 椭圆（稳态） → 抛物（扩散） → 双曲（传播）
// → 方法与数值。共 6 Part、19 Chapter。
//
// 职责边界：
//   - Fourier 理论 → Analyse Harmonique（交叉引用）
//   - Sobolev 空间：嵌入定理等深层理论 → Analyse Harmonique（交叉引用；
//     W^{k,p} 定义与基本性质在 Ch 8 简述，以支撑弱解与正则性）
//   - Banach / Hilbert 抽象理论 → Analyse Fonctionnelle（交叉引用）
//   - 弱形式、Lax-Milgram、Galerkin、变分方法的抽象框架 → Analyse Fonctionnelle（交叉引用；
//     在椭圆/抛物边值问题中的应用属本笔记）
//   - 谱理论（抽象部分） → Analyse Fonctionnelle（交叉引用）
//   - L^p / 测度论 → Analyse Réelle（交叉引用）
//   - Hamilton-Jacobi 的力学应用 → Mécanique analytique（交叉引用）
//   - 调和函数的复分析视角 → Analyse Complexe（交叉引用）
//   - 应用 PDE（流体、薛定谔等） → 各专门笔记
//
// 结构决策：
//   - 一阶理论（特征线法、守恒律）移至 Part V（双曲型）开头：
//     一阶方程本质上是双曲的，特征线法是双曲型方程的核心工具
//   - 抛物型与双曲型分立为 Part IV 和 Part V：
//     两者数学性质差异极大（扩散 vs 传播），混在一起会模糊主线叙事
//   - Part VI（方法与数值）保留为独立过渡 Part，标注"本部分仅作导论"
//
// ==========================================================================
// Part I — Foundations and Classification (基础：分类框架)
// ==========================================================================
// 设计思路：PDE 基本语言、适定性概念，二阶方程的椭圆/抛物/双曲分类框架
// 与标准形。对应教材：PDE 教材前 2 章。

// --- Chapter 1: Introduction to PDEs (偏微分方程导论) ---
// --- Chapter 2: Classification of Second-Order PDEs (二阶偏微分方程分类) ---

// ==========================================================================
// Part II — Distribution Theory (分布理论)
// ==========================================================================
// 设计思路：分布理论是为三类方程服务的工具层。基本解在此统一构造；
// 椭圆 Green 函数章不再重复。对应教材：通常占据 PDE 教材 1-2 章（或附录）。

// --- Chapter 3: Distributions and Weak Derivatives (分布与弱导数) ---
// --- Chapter 4: Convolution and Fundamental Solutions (卷积与基本解) ---

// ==========================================================================
// Part III — Elliptic Equations (椭圆型方程)
// ==========================================================================
// 设计思路：从 Laplace 方程的经典理论出发，逐步过渡到一般椭圆方程的
// 弱解理论和正则性。

// --- Chapter 5: Laplace's Equation and Harmonic Functions (拉普拉斯方程与调和函数) ---
// --- Chapter 6: Boundary Value Problems for Elliptic Equations (椭圆型方程边值问题) ---
// --- Chapter 7: Green Functions and Representation (格林函数与表示) ---
// --- Chapter 8: Regularity Theory (正则性理论) ---

// ==========================================================================
// Part IV — Parabolic Equations (抛物型方程)
// ==========================================================================
// 设计思路：热方程为核心模型，建立存在性、唯一性、正则性和长期行为理论。
// 半群理论作为统一框架嵌入。

// --- Chapter 9: The Heat Equation (热方程) ---
// --- Chapter 10: Linear Parabolic Boundary Value Problems (线性抛物型边值问题) ---
// --- Chapter 11: Nonlinear Parabolic Equations (非线性抛物型方程) ---

// ==========================================================================
// Part V — Hyperbolic Equations and First-Order Theory (双曲型方程与一阶理论)
// ==========================================================================
// 设计思路：以波动方程为核心模型，建立双曲型方程的经典理论和现代守恒律理论。
// 一阶理论（特征线法、守恒律）作为双曲型的前置理论置于本 Part 开头。
// 标量一维守恒律在 Ch 14 完整处理；Ch 17 专注系统情形增量。

// --- Chapter 12: Method of Characteristics and Quasilinear Equations (特征线法与拟线性方程) ---
// --- Chapter 13: Hamilton--Jacobi Equations (Hamilton--Jacobi 方程) ---
// --- Chapter 14: Conservation Laws in One Space Dimension (一维守恒律) ---
// --- Chapter 15: Wave Equation (波动方程) ---
// --- Chapter 16: Linear Hyperbolic Systems (线性双曲系统) ---
// --- Chapter 17: Conservation Laws for Systems (守恒律系统) ---

// ==========================================================================
// Part VI — Solution Methods and Numerical Methods (求解方法与数值方法)
// ==========================================================================
// 设计思路：本部分仅作导论，深入数值分析参见数值分析相关笔记。
// 分离变量法在波方程中的应用已在 Ch 15 处理。

// --- Chapter 18: Separation of Variables and Spectral Methods (分离变量与谱方法) ---
// --- Chapter 19: Numerical Methods for PDEs (PDE 数值方法) ---

// ==========================================================================
// 结构说明 (Structure Note)
// ==========================================================================
// 本笔记遵循「语言框架 → 分布工具 → 椭圆（稳态） → 抛物（扩散） →
// 双曲（传播） → 方法与数值」的六段式主线，共 6 Part、19 Chapter。
//
// Part I（Ch 1–2，基础）：PDE 基本语言、适定性、二阶分类框架。
// Part II（Ch 3–4，工具）：分布理论、弱导数、卷积、基本解。
// Part III（Ch 5–8，椭圆）：Laplace → 边值问题 → Green 函数 → 正则性。
// Part IV（Ch 9–11，抛物）：热方程 → 线性抛物边值 → 非线性反应-扩散。
// Part V（Ch 12–17，双曲+一阶）：特征线法 → Hamilton-Jacobi → 守恒律
//   → 波动方程 → 线性双曲系统 → 守恒律系统。
// Part VI（Ch 18–19，方法与数值）：分离变量、谱方法、数值方法概览。
//
// 教材覆盖：PDE 教材全部知识点均已覆盖。
// ==========================================================================
''')
    
    # Add chapters with references updated
    for part_title, old_chapters in PART_ORDER:
        out.append(f'#part("{part_title}") // {part_title}\n')
        for old_ch in old_chapters:
            ch_text = ''.join(chapters[old_ch])
            ch_text = ref_updates(ch_text)
            out.append(ch_text)
    
    # Add postamble
    out.extend(postamble)
    
    # Write
    with open(path, 'w', encoding='utf-8') as f:
        f.write(''.join(out))
    
    print("Done!")

if __name__ == '__main__':
    main()
