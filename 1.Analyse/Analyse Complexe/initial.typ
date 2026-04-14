#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Analyse Complexe",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Analyse Complexe",
  "Violet",
  subtitle: "A notebook for complex analysis",
  institute: "Notiz  Mathematiques",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for complex analysis.",
)

#make-outline(depth: 2, title: "Contents")


#part("Basic Complex Analysis") // 基础复分析
#include "chapters/ComplexNumber.typ" // 复数与复平面
#include "chapters/ComplexFunction.typ" // 复函数
#include "chapters/ComplexIntegral.typ" // 复积分






#bibliography("references.bib")