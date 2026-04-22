#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Analyse Réelle",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Analyse Réelle",
  "Violet",
  subtitle: "A notebook for real analysis",
  institute: "Notiz  Mathematiques",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for real analysis.",
)

#make-outline(depth: 2, title: "Contents")

#part("Basic Real Analysis") // 基础实分析
#include "chapters/LebesgueMeasure.typ" // 勒贝格测度
#include "chapters/MeasurableFunction.typ" // 可测函数
#include "chapters/LebesgueIntegration.typ" // 勒贝格积分


*只有被引用的章节才会被编译和显示在目录中，因此如果你想要显示某个章节，请确保在主文件中正确引用了它。*
refer to @zhou2016

#bibliography("references.bib")