#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Probabilités", // 概率论
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Probabilités", // 概率论
  "Violet",
  subtitle: "A notebook for probability",
  institute: "Notiz Mathematiques",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for probability.",
)

#make-outline(depth: 2, title: "Contents")






#bibliography("references.bib")

// 目录

