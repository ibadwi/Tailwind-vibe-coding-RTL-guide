# مقطع قواعد RTL — للّصق في ملف تعليمات مساعدك البرمجي

انسخ الكتلة أدناه إلى ملف تعليمات الأداة التي تكتب بها الكود بجذر مشروعك
(`CLAUDE.md` لـ Claude Code، `.cursorrules` لـ Cursor، أو ما يماثله)،
فتلتزم الأداة بقواعد RTL في كل جلسة تلقائياً. الشرح الكامل في [`rtl-guide.md`](./rtl-guide.md).

````markdown
## قواعد الواجهة العربية (RTL) — إلزامية

- الموقع عربي بالكامل: التخطيط الجذري يبدأ بـ `<html lang="ar" dir="rtl">`.
- استخدم حصراً أصناف Tailwind المنطقية، وامتنع نهائياً عن الفيزيائية (حتى مع بادئة مثل file:/lg:):
  ms-*/me-* بدلاً من ml-*/mr-*، ps-*/pe-* بدلاً من pl-*/pr-*،
  text-start/text-end بدلاً من text-left/right، start-*/end-* بدلاً من left-*/right-*،
  rounded-s-*/rounded-e-* بدلاً من rounded-l-*/r-*، border-s-*/e-* بدلاً من border-l-*/r-*،
  float-start/end، clear-start/end، ms-auto/me-auto، scroll-ms-*/scroll-me-*.
- الأصناف بلا بديل منطقي (translate-x-*, origin-*, skew-x-*, bg-left/right, object-left/right)
  تُزوَّج بمتغيّر rtl:. والأيقونات الاتجاهية (أسهم/chevrons) تستخدم rtl:rotate-180.
- المقاطع اللاتينية/الأرقام/الروابط تُلَفّ بـ dir="ltr"، والمحتوى مجهول الاتجاه بـ <bdi>.
- في CSS/JS استخدم الخصائص المنطقية (marginInlineStart وأخواتها).
````
