#import "../../TypstTemplate/math-notes.typ": *

#set document(
  title: "Électrodynamique",
  author: "Violet",
  date: datetime.today(),
)

#show: apply-style

// --------------------------------------------------------------------------
// Cover + Outline
// --------------------------------------------------------------------------

#make-cover(
  "Électrodynamique",
  "Violet",
  subtitle: "A notebook for electrodynamics",
  institute: "Notiz Physique",
  date: datetime.today().display(),
  version: "v0.2.0",
  extra-info: "This is a notebook for electrodynamics.",
)

#make-outline(depth: 2, title: "Contents")


#part("Basic Real Analysis") // 基础实分析




