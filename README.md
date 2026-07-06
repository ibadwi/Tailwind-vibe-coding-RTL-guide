# دليل RTL لـ Tailwind — Tailwind RTL Guide (العربية)

> A battle-tested checklist + scripts that keep your **Arabic / RTL** Tailwind UI from breaking.
> دليل عملي + سكربتات فحص تمنع كسر واجهات **العربية (RTL)** المبنية بـ Tailwind.

نحو **400 مليون** إنسان يقرؤون من اليمين لليسار، ومعظم الكود المولَّد (بشرياً أو بالذكاء الاصطناعي)
يستخدم أصنافاً **فيزيائية** (`ml-*`, `text-left`, `left-0`…) تثبّت الاتجاه يساراً فتنكسر الواجهة العربية.
الحل: أصناف Tailwind **المنطقية** (`ms-*`, `text-start`, `start-0`…) التي تنقلب تلقائياً مع اتجاه الصفحة.

هذه الحزمة تعطيك **قاعدة ذهبية + جداول تحويل + 3 طبقات حماية + سكربت فحص جاهز لـ CI**.

## 🚀 البدء السريع

1. **علّم مساعدك البرمجي القاعدة** — انسخ محتوى [`CLAUDE.md-snippet.md`](./CLAUDE.md-snippet.md)
   إلى ملف تعليمات أداتك (`CLAUDE.md` لـ Claude Code، `.cursorrules` لـ Cursor…).
2. **افحص قوالبك قبل كل تسليم:**
   ```bash
   ./scripts/rtl-check.sh resources/views   # أو src أو .
   ```
3. **اقرأ الدليل الكامل** — [`rtl-guide.md`](./rtl-guide.md): جداول التحويل، الأصناف بلا بديل منطقي،
   عزل النصوص المختلطة، وطبقة ESLint.

## 📦 ماذا بداخل الحزمة؟

| الملف | الغرض |
|---|---|
| [`rtl-guide.md`](./rtl-guide.md) | الدليل المرجعي الكامل (عربي) |
| [`CLAUDE.md-snippet.md`](./CLAUDE.md-snippet.md) | قواعد جاهزة للّصق في ملف تعليمات مساعدك البرمجي |
| [`scripts/rtl-check.sh`](./scripts/rtl-check.sh) | فحص آلي للقوالب (grep/ugrep، رمز خروج لـ CI) |
| [`LICENSE`](./LICENSE) | ترخيص مزدوج (النص CC BY 4.0 / السكربت MIT) |

## 🤖 مثال في CI (GitHub Actions)

```yaml
- name: RTL check
  run: ./scripts/rtl-check.sh resources/views
```

يفشل الإجراء (exit 1) عند وجود صنف فيزيائي له بديل منطقي، أو صنف بلا بديل منطقي وبلا متغيّر `rtl:`.

## 🙌 المساهمة

مرحبٌ بأي تحسين: أصناف ناقصة في الجداول، دعم أطر أخرى، ترجمة كاملة للإنجليزية.
افتح Issue أو Pull Request.

## 📄 الترخيص والنسبة

- النصوص والدليل: **CC BY 4.0**. السكربتات: **MIT**. التفاصيل في [`LICENSE`](./LICENSE).
- الفكرة ونهج الفحص الآلي مبنيّان على عمل **[عمّار العقّاد](https://ammar.codes/posts/eslint-tailwind-rtl/)**
  وإضافته **[eslint-plugin-tailwind-rtl](https://github.com/AmmarCodes/eslint-plugin-tailwind-rtl)**.
