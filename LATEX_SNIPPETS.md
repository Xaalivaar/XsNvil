# Complete LaTeX Snippet Trigger Catalog

[← Documentation index](README.md) · [Snippet workflow](LATEX_SETUP.md)

> **Source inventory:** [`iurimateus/luasnip-latex-snippets.nvim`](https://github.com/iurimateus/luasnip-latex-snippets.nvim), `main` branch, inspected 24 November 2026. The repository is not pinned to a commit by `init.lua`; future updates may change this list. This catalog describes the supplied source inventory, not a runtime test of your machine. All source autosnippets are intended to require `<Tab>` under the provided `init.lua`.

## How to read this catalog

- **All entries are manual in this configuration:** type a trigger and press `<Tab>` when its context matches. Section names below indicate the **upstream source category**, not expansion behavior here.
- **Math**: needs a VimTeX-detected math context in `.tex`. **Text**: outside math. **BOL**: beginning of line. **No `\`**: will not match when immediately preceded by a backslash.
- **Pattern**: the entry is a Lua-pattern trigger, not literal text. Captures supply portions of the expansion. Backticks preserve punctuation and letter case.
- `…` in descriptions marks an editable placeholder, not an actual output character. Snippet expansions may contain multiple tab stops.
- Original plugin definitions include both manual and automatic triggers; this configuration converts the latter to manual on registration.

## Upstream manual snippets (inside mathematics)

| Trigger | Expansion / purpose | Activation |
| :--- | :--- | :--- |
| `sum` | \\sum_{n=1}^{\\infty} … | math, manual |
| `taylor` | Taylor-series summation | math, manual |
| `lim` | limit with subscript | math, manual |
| `limsup` | limit superior with subscript | math, manual |
| `prod` | product with limits | math, manual |
| `part` | partial derivative fraction | math, manual |
| `ddx` | ordinary derivative fraction | math, manual |
| `pmat` | pmatrix environment | math, manual |
| `lr` | sized parentheses | math, manual |
| `lr(` | sized parentheses | math, manual |
| `lr\|` | sized vertical bars | math, manual |
| `lr{` | sized braces | math, manual |
| `lr[` | sized square brackets | math, manual |
| `lra` | sized angle brackets | math, manual |
| `lrb` | sized braces | math, manual |
| `sequence` | indexed sequence with limits | math, manual |

## Upstream automatic snippets outside mathematics (manual here)

| Trigger | Expansion / purpose | Condition |
| :--- | :--- | :--- |
| `mk` | \\( … \\) | text |
| `dm` | \\[ … \\] | text |
| `ali` | align* environment | text + start of line |
| `beg` | \\begin{env} … \\end{env} | text + start of line |
| `bigfun` | align* function mapping layout | text + start of line |

**Markdown/Quarto caveat:** `allow_on_markdown = true` loads a filtered variant. In Markdown, `mk` becomes `$…$` and `dm` becomes `$$…$$` rather than the `.tex` delimiters; `ali`, `beg`, and `bigfun` are re-added for Markdown math zones. Context detection there uses Tree-sitter rather than the VimTeX path configured for `.tex`.

## Upstream automatic literal triggers inside mathematics (manual here)

### Symbols, structures, and mathematics (`math_iA.lua`)

| Trigger | Expansion / purpose | Condition |
| :--- | :--- | :--- |
| `td` | superscript placeholder | math; manual here |
| `rd` | parenthesized superscript | math; manual here |
| `cb` | cube exponent | math; manual here |
| `sr` | square exponent | math; manual here |
| `EE` | \exists | math; manual here |
| `AA` | \forall | math; manual here |
| `xnn` | x_n | math; manual here |
| `ynn` | y_n | math; manual here |
| `xii` | x_i | math; manual here |
| `yii` | y_i | math; manual here |
| `xjj` | x_j | math; manual here |
| `yjj` | y_j | math; manual here |
| `xp1` | x_{n+1} | math; manual here |
| `xmm` | x_m | math; manual here |
| `R0+` | \mathbb{R}_0^+ | math; manual here |
| `notin` | \not\in | math; manual here |
| `cc` | \subset | math; manual here |
| `<->` | \leftrightarrow | math; manual here |
| `...` | \ldots | math; manual here |
| `!>` | \mapsto | math; manual here |
| `iff` | \iff | math; manual here |
| `siff` | \Leftrightarrow | math; manual here |
| `ooo` | \infty | math; manual here |
| `rij` | indexed sequence | math; manual here |
| `nabl` | \nabla | math; manual here |
| `<!` | \triangleleft | math; manual here |
| `floor` | floor brackets | math; manual here |
| `mcal` | \mathcal{…} | math; manual here |
| `//` | \frac{…}{…} | math; manual here |
| `\\\` | \setminus | math; manual here |
| `->` | \to | math; manual here |
| `-->` | \longrightarrow | math; manual here |
| `letw` | Let Omega be an open subset of C (prose) | math; manual here |
| `nnn` | \bigcap with limits | math; manual here |
| `norm` | norm bars | math; manual here |
| `<>` | \diamond | math; manual here |
| `>>` | \gg | math; manual here |
| `<<` | \ll | math; manual here |
| `stt` | text subscript | math; manual here |
| `tt` | \text{…} | math; manual here |
| `xx` | \times | math; manual here |
| `**` | \cdot | math; manual here |
| `:=` | \coloneqq | math; manual here |
| `cvec` | column vector in pmatrix | math; manual here |
| `ceil` | ceiling brackets | math; manual here |
| `OO` | \O | math; manual here |
| `RR` | \mathbb{R} | math; manual here |
| `QQ` | \mathbb{Q} | math; manual here |
| `ZZ` | \mathbb{Z} | math; manual here |
| `UU` | \cup | math; manual here |
| `NN` | \mathbb{N} | math; manual here |
| `\|\|` | `\mid` | math; manual here |
| `Nn` | \cap | math; manual here |
| `bmat` | bmatrix environment | math; manual here |
| `uuu` | \bigcup with limits | math; manual here |
| `DD` | \mathbb{D} | math; manual here |
| `HH` | \mathbb{H} | math; manual here |
| `lll` | \ell | math; manual here |
| `dint` | integral with bounds | math; manual here |
| `==` | aligned equals plus line break | math; manual here |
| `!=` | \neq | math; manual here |
| `compl` | complement superscript | math; manual here |
| `__` | subscript placeholder | math; manual here |
| `=>` | \implies | math; manual here |
| `simp` | \Rightarrow | math; manual here |
| `=<` | \impliedby | math; manual here |
| `<=` | \le | math; manual here |
| `>=` | \ge | math; manual here |
| `invs` | inverse exponent | math; manual here |
| `~~` | \sim | math; manual here |
| `conj` | \overline{…} | math; manual here |

> Note: `<<` is defined **twice** in upstream `math_iA.lua` (the duplicate is intentionally shown only once here).

### Mathematical words (`math_wA_no_backslash.lua`)

| Trigger | Expansion / purpose | Condition |
| :--- | :--- | :--- |
| `arcsin` | \\arcsin | math + no preceding backslash; manual here |
| `arctan` | \\arctan | math + no preceding backslash; manual here |
| `arcsec` | \\arcsec | math + no preceding backslash; manual here |
| `asin` | \\arcsin | math + no preceding backslash; manual here |
| `atan` | \\arctan | math + no preceding backslash; manual here |
| `asec` | \\arcsec | math + no preceding backslash; manual here |
| `set` | escaped set braces | math + no preceding backslash; manual here |
| `fun` | function-map template | math + no preceding backslash; manual here |
| `abs` | \\abs{…} | math + no preceding backslash; manual here |

**Package note:** The `abs` expansion uses `\abs{…}`, which requires a suitable macro (for example, one declared with `mathtools`); the plugin does not supply that LaTeX macro.

## Upstream automatic mathematical pattern triggers (manual here)

### Letter-prefix adornments (`math_iA.lua`)

| Trigger | Expansion / purpose | Condition |
| :--- | :--- | :--- |
| `(%a+)bar` | overline the preceding letters | math + no preceding backslash; manual here |
| `(%a+)und` | underline the preceding letters | math + no preceding backslash; manual here |
| `(%a)dot` | dot accent on one preceding letter | math + no preceding backslash; manual here |
| `(%a+)hat` | hat accent on preceding letters | math + no preceding backslash; manual here |
| `(%a+)ora` | right arrow over preceding letters | math + no preceding backslash; manual here |
| `(%a+)ola` | left arrow over preceding letters | math + no preceding backslash; manual here |

### Fractions and subscripts (`math_wrA.lua`)

| Trigger | Expansion / purpose | Condition |
| :--- | :--- | :--- |
| `([%a])(%d)` | single-letter subscript: `x2` → `x_{2}` | math; manual here; Lua pattern |
| `([%a])_(%d%d)` | two-digit subscript: `x_12` → `x_{12}` | math; manual here; Lua pattern |
| `.*%)/` | parenthesized expression followed by `/` becomes a fraction | math; manual here; Lua pattern |
| `(\?[%w]+\?^%w)/` | fraction from token with single-character superscript | math; manual here; Lua pattern |
| `(\?[%w]+\?_%w)/` | fraction from token with single-character subscript | math; manual here; Lua pattern |
| `(\?[%w]+\?^{%w*})/` | fraction from token with braced superscript | math; manual here; Lua pattern |
| `(\?[%w]+\?_{%w*})/` | fraction from token with braced subscript | math; manual here; Lua pattern |
| `(\?%w+)/` | fraction from word/token before `/` | math; manual here; Lua pattern |

### Vector punctuation (`math_wRA_no_backslash.lua`)

| Trigger | Expansion / purpose | Condition |
| :--- | :--- | :--- |
| `([%a][%a])(%.,)` | vector accent on captured letters | math + no preceding backslash; manual here; Lua pattern |
| `([%a][%a])(,%.)` | vector accent on captured letters | math + no preceding backslash; manual here; Lua pattern |
| `([%a])(%.,)` | vector accent on captured letters | math + no preceding backslash; manual here; Lua pattern |
| `([%a])(,%.)` | vector accent on captured letters | math + no preceding backslash; manual here; Lua pattern |

### Full-word Greek, operators, and postfix commands (`math_rA_no_backslash.lua`)

All entries in the following tables are **upstream automatic Lua-pattern triggers (manual here)**. Brackets such as `[aA]` indicate uppercase/lowercase variants, not a literal trigger. They expand to the corresponding backslashed command when there is no preceding `\`.

#### Greek-letter patterns

| Trigger | Expansion / purpose | Condition |
| :--- | :--- | :--- |
| `([aA]lpha)` | \\alpha / uppercase-initial variant | math + no preceding backslash; manual here |
| `([bB]eta)` | \\beta / uppercase-initial variant | math + no preceding backslash; manual here |
| `([cC]hi)` | \\chi / uppercase-initial variant | math + no preceding backslash; manual here |
| `([dD]elta)` | \\delta / uppercase-initial variant | math + no preceding backslash; manual here |
| `([eE]psilon)` | \\epsilon / uppercase-initial variant | math + no preceding backslash; manual here |
| `([gG]amma)` | \\gamma / uppercase-initial variant | math + no preceding backslash; manual here |
| `([iI]ota)` | \\iota / uppercase-initial variant | math + no preceding backslash; manual here |
| `([kK]appa)` | \\kappa / uppercase-initial variant | math + no preceding backslash; manual here |
| `([lL]ambda)` | \\lambda / uppercase-initial variant | math + no preceding backslash; manual here |
| `([mM]u)` | \\mu / uppercase-initial variant | math + no preceding backslash; manual here |
| `([nN]u)` | \\nu / uppercase-initial variant | math + no preceding backslash; manual here |
| `([oO]mega)` | \\omega / uppercase-initial variant | math + no preceding backslash; manual here |
| `([pP]hi)` | \\phi / uppercase-initial variant | math + no preceding backslash; manual here |
| `([pP]i)` | \\pi / uppercase-initial variant | math + no preceding backslash; manual here |
| `([pP]si)` | \\psi / uppercase-initial variant | math + no preceding backslash; manual here |
| `([rR]ho)` | \\rho / uppercase-initial variant | math + no preceding backslash; manual here |
| `([sS]igma)` | \\sigma / uppercase-initial variant | math + no preceding backslash; manual here |
| `([tT]au)` | \\tau / uppercase-initial variant | math + no preceding backslash; manual here |
| `([tT]heta)` | \\theta / uppercase-initial variant | math + no preceding backslash; manual here |
| `([zZ]eta)` | \\zeta / uppercase-initial variant | math + no preceding backslash; manual here |
| `([eE]ta)` | \\eta / uppercase-initial variant | math + no preceding backslash; manual here |

#### Variant Greek patterns

| Trigger | Expansion / purpose | Condition |
| :--- | :--- | :--- |
| `(varepsilon)` | \\varepsilon | math + no preceding backslash; manual here |
| `(varphi)` | \\varphi | math + no preceding backslash; manual here |
| `(varrho)` | \\varrho | math + no preceding backslash; manual here |
| `(vartheta)` | \\vartheta | math + no preceding backslash; manual here |

#### Function/operator patterns

| Trigger | Expansion / purpose | Condition |
| :--- | :--- | :--- |
| `(sin)` | \\sin | math + no preceding backslash; manual here |
| `(cos)` | \\cos | math + no preceding backslash; manual here |
| `(tan)` | \\tan | math + no preceding backslash; manual here |
| `(csc)` | \\csc | math + no preceding backslash; manual here |
| `(sec)` | \\sec | math + no preceding backslash; manual here |
| `(cot)` | \\cot | math + no preceding backslash; manual here |
| `(ln)` | \\ln | math + no preceding backslash; manual here |
| `(log)` | \\log | math + no preceding backslash; manual here |
| `(exp)` | \\exp | math + no preceding backslash; manual here |
| `(star)` | \\star | math + no preceding backslash; manual here |
| `(perp)` | \\perp | math + no preceding backslash; manual here |
| `(int)` | \\int | math + no preceding backslash; manual here |
| `(q?quad)` | \\quad or \\qquad | math + no preceding backslash; manual here |

**Why parentheses?** These are the literal trigger patterns built at runtime by `postfix_trig(match)`. For example, the source constructs `([aA]lpha)` from `[aA]lpha`.

## Counts and completeness

- `math_i.lua`: 16 manual math triggers in the supplied upstream inventory. The current `init.lua` does **not** define a `pac` trigger.
- `wA.lua` + `bwA.lua`: 5 text-mode triggers (with Markdown adaptations).
- `math_iA.lua`: 71 unique literal triggers, plus 6 letter-prefix pattern triggers; `<<` is repeated in source.
- `math_wA_no_backslash.lua`: 9 triggers.
- `math_wrA.lua`: 8 pattern triggers.
- `math_wRA_no_backslash.lua`: 4 vector patterns.
- `math_rA_no_backslash.lua`: 21 Greek patterns + 4 variant Greek + 12 operators + 1 `q?quad` pattern.

These rows account for every trigger constructor in the source modules referenced by the plugin entrypoint at the time of inspection. **Patterns can match many different strings**; enumerating every possible match would be impossible, so their actual definitions are documented.

## Original source files

The plugin source is the authority when behavior changes:

- [`init.lua`](https://github.com/iurimateus/luasnip-latex-snippets.nvim/blob/main/lua/luasnip-latex-snippets/init.lua)
- [`math_i.lua`](https://github.com/iurimateus/luasnip-latex-snippets.nvim/blob/main/lua/luasnip-latex-snippets/math_i.lua)
- [`math_iA.lua`](https://github.com/iurimateus/luasnip-latex-snippets.nvim/blob/main/lua/luasnip-latex-snippets/math_iA.lua)
- [`math_wA_no_backslash.lua`](https://github.com/iurimateus/luasnip-latex-snippets.nvim/blob/main/lua/luasnip-latex-snippets/math_wA_no_backslash.lua)
- [`math_wrA.lua`](https://github.com/iurimateus/luasnip-latex-snippets.nvim/blob/main/lua/luasnip-latex-snippets/math_wrA.lua)
- [`math_wRA_no_backslash.lua`](https://github.com/iurimateus/luasnip-latex-snippets.nvim/blob/main/lua/luasnip-latex-snippets/math_wRA_no_backslash.lua)
- [`math_rA_no_backslash.lua`](https://github.com/iurimateus/luasnip-latex-snippets.nvim/blob/main/lua/luasnip-latex-snippets/math_rA_no_backslash.lua)
- [`wA.lua`](https://github.com/iurimateus/luasnip-latex-snippets.nvim/blob/main/lua/luasnip-latex-snippets/wA.lua)
- [`bwA.lua`](https://github.com/iurimateus/luasnip-latex-snippets.nvim/blob/main/lua/luasnip-latex-snippets/bwA.lua)

## Inspect your installed version

To see the exact set loaded in **your** Neovim (including any future additions or local overrides), open a `.tex` file and run:

```vim
:lua print(#require("luasnip").get_snippets("tex"))
```

For a trigger list, run:

```vim
:lua for _,s in ipairs(require("luasnip").get_snippets("tex")) do print(s.trigger) end
```

`get_snippets` may include both automatic and manually expanded entries depending on LuaSnip version; inspect separate collections via `require("luasnip").get_snippets()` if needed. This guide lists upstream definitions, not every possible user-defined override.
