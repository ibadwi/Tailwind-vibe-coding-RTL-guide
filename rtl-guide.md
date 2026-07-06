# دليل ضمان سلامة الواجهة العربية (RTL) مع Tailwind

> **لمن؟** مرجع دائم لبناء وتصميم أي موقع عربي (أو أي واجهة RTL) بـ Tailwind دون أخطاء اتجاه — يُطبَّق منذ أول سطر كود.
>
> **كيف تستفيد منه؟** انسخ مقطع «قواعد الواجهة العربية (RTL)» (الطبقة 1 أدناه) إلى ملف تعليمات مساعدك البرمجي
> (مثل `CLAUDE.md` أو `.cursorrules`)، واجعل أمرَي الفحص (الطبقة 3) جزءاً من مراجعتك قبل كل تسليم.

---

## الفكرة الأساسية

استخدم أصناف Tailwind **المنطقية** (Logical Properties) التي تنقلب تلقائياً مع اتجاه الصفحة
بدل الأصناف **الفيزيائية** التي تثبّت الاتجاه يساراً — فتعمل الواجهة نفسها بالعربية والإنجليزية دون أي كود إضافي.

---

## القاعدة الذهبية

> **ممنوع `left`/`right` — مسموح `start`/`end`.**
>
> كل صنف يحمل `l` أو `r` أو `left` أو `right` له بديل منطقي بـ `s` أو `e` أو `start` أو `end`.

> **تنبيه البادئات:** القاعدة تسري حتى لو سبق الصنفَ متغيّرٌ مثل `lg:` أو `hover:` أو `file:`.
> فـ `file:mr-3` مخالف تماماً كـ `mr-3`، والصواب `file:me-3`. والسالب `-ml-4` يصبح `-ms-4`.

### 1) جدول التحويل — أصناف لها بديل منطقي (حوّلها دائماً)

| ❌ فيزيائي (يكسر العربية) | ✅ منطقي (يعمل بالاتجاهين) | ماذا يفعل |
|---|---|---|
| `ml-4` | `ms-4` | هامش بداية السطر (margin-inline-start) |
| `mr-2` | `me-2` | هامش نهاية السطر (margin-inline-end) |
| `ml-auto` | `ms-auto` | دفع العنصر إلى النهاية داخل flex |
| `mr-auto` | `me-auto` | دفع العنصر إلى البداية داخل flex |
| `pl-3` | `ps-3` | حشوة بداية السطر (padding-inline-start) |
| `pr-1` | `pe-1` | حشوة نهاية السطر (padding-inline-end) |
| `text-left` | `text-start` | محاذاة النص |
| `text-right` | `text-end` | محاذاة النص |
| `left-0` | `start-0` | تموضع العناصر (absolute/fixed) |
| `right-0` | `end-0` | تموضع العناصر |
| `float-left` | `float-start` | التعويم |
| `float-right` | `float-end` | التعويم |
| `clear-left` | `clear-start` | إلغاء التعويم |
| `clear-right` | `clear-end` | إلغاء التعويم |
| `scroll-ml-4` | `scroll-ms-4` | هامش تمرير (scroll-margin) |
| `scroll-pr-4` | `scroll-pe-4` | حشوة تمرير (scroll-padding) |
| `rounded-l-lg` | `rounded-s-lg` | استدارة الجانب |
| `rounded-r-lg` | `rounded-e-lg` | استدارة الجانب |
| `rounded-tl-lg` | `rounded-ss-lg` | استدارة زاوية (بداية-أعلى) |
| `rounded-tr-lg` | `rounded-se-lg` | استدارة زاوية (نهاية-أعلى) |
| `rounded-bl-lg` | `rounded-es-lg` | استدارة زاوية (بداية-أسفل) |
| `rounded-br-lg` | `rounded-ee-lg` | استدارة زاوية (نهاية-أسفل) |
| `border-l-2` | `border-s-2` | الحدود |
| `border-r-2` | `border-e-2` | الحدود |

> الأصناف المنطقية مدعومة في **Tailwind 3.3 فما فوق** (بما فيها v4) بدون أي إعداد.
> ملاحظة: `justify-start` و`items-end` و`px-*`/`py-*` منطقية أو محايدة أصلاً — لا تحتاج تحويلاً.

### 2) أصناف بلا بديل منطقي — استخدم متغيّر `rtl:`

بعض الأصناف **لا مقابل منطقي لها** في Tailwind، فتبقى فيزيائية دائماً. الحل الرسمي:
أضف نسخة معدّلة بمتغيّر `rtl:` (أو زوّجها `ltr:`/`rtl:`) لتنقلب يدوياً.

| ❌ فيزيائي بلا بديل | ✅ الإصلاح بمتغيّر `rtl:` | ملاحظة |
|---|---|---|
| `translate-x-4` | `translate-x-4 rtl:-translate-x-4` | الإزاحة الأفقية تعكس إشارتها في RTL |
| `origin-left` / `origin-bottom-left` | `origin-left rtl:origin-right` | نقطة أصل التحويل |
| `skew-x-6` | `skew-x-6 rtl:-skew-x-6` | الميل الأفقي |
| `bg-left` / `object-left` | `bg-left rtl:bg-right` | موضع الخلفية/الصورة |
| سهم/chevron يشير يساراً | `rtl:rotate-180` | يقلب الأيقونات الاتجاهية |
| `space-x-4` في صف أفقي | يُفضَّل استبداله بـ `gap-4` | `gap` محايد الاتجاه ولا يحتاج عكساً |

النمط الرسمي من توثيق Tailwind v4 (يصلح للمواقع ثنائية الاتجاه):

```html
<div class="ltr:ml-3 rtl:mr-3">…</div>
```

### 3) النصوص المختلطة (أرقام/إنجليزي/روابط/كود) — العزل ثنائي الاتجاه

هذه مشكلة RTL **لا علاقة لها بـ Tailwind**: عند دسّ نصٍّ لاتيني أو أرقام أو رابط داخل
جملة عربية، قد ينقلب ترتيبه أو تقفز علامات الترقيم لمكان خاطئ (خاصة الأقواس والنقطتان).

- لُفَّ المقاطع ذات الاتجاه المعروف (روابط، بريد، كود، هاتف) بـ `dir="ltr"`:
  ```html
  <span dir="ltr">+90 555 123 4567</span>
  <code dir="ltr">npm run build</code>
  ```
- لُفَّ المحتوى **مجهول الاتجاه** (اسم مستخدم، مدخلات، عنوان قد يكون عربياً أو إنجليزياً) بـ `<bdi>`:
  ```html
  <bdi>{{ userName }}</bdi>
  ```
  فيعزل Unicode اتجاهه عن الجملة المحيطة ويمنع «تسرّب» الاتجاه.

### وفي CSS داخل JavaScript (إن وُجد)

```javascript
// ❌ يكسر العربية
const styles = { marginLeft: "1rem", paddingRight: "2rem" };

// ✅ يعمل بالاتجاهين
const styles = { marginInlineStart: "1rem", paddingInlineEnd: "2rem" };
```

---

## طبقات الحماية الثلاث

### الطبقة 1 — تعليمات الذكاء الاصطناعي (خط الدفاع الأول)

إن كنت تكتب الكود بمساعدة أداة ذكاء اصطناعي (Claude Code، Cursor، Copilot…)، فأقوى حارس
هو تعليمات دائمة تلتزمها الأداة في كل جلسة. أضف هذا المقطع إلى ملف تعليماتها
(`CLAUDE.md` أو `.cursorrules` أو ما يماثله بجذر مشروعك):

```markdown
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
```

### الطبقة 2 — حارس آلي بـ ESLint (لمن يكتب JavaScript)

الإضافة مفتوحة المصدر [`eslint-plugin-tailwind-rtl`](https://github.com/AmmarCodes/eslint-plugin-tailwind-rtl)
تفحص أصناف Tailwind داخل ملفات JS/JSX/TS وخصائص CSS-in-JS، وتصلّح تلقائياً بـ `--fix`:

```bash
npm install --save-dev eslint eslint-plugin-tailwind-rtl
```

```javascript
// eslint.config.js — الإعداد الأساسي
import tailwindRtl from "eslint-plugin-tailwind-rtl";

export default [tailwindRtl.configs.recommended];
```

للتشديد (خطأ يوقف الـ build بدل تحذير):

```javascript
import tailwindRtl from "eslint-plugin-tailwind-rtl";

export default [
  tailwindRtl.configs.recommended,
  {
    rules: {
      "tailwind-rtl/tailwind/no-physical-classes": "error",
    },
  },
];
```

ثم الإصلاح التلقائي لكل المخالفات: `npx eslint . --fix`

> **ملاحظة:** الإضافة تغطي ملفات JavaScript فقط ولا ترى قوالب الخوادم (Blade/Twig/ERB…) — لهذا الطبقة 1 هي
> خط الدفاع الأساسي، والطبقة 3 (grep) تسدّ ثغرة القوالب مهما كانت لغتها.

### الطبقة 3 — فحص القوالب قبل كل تسليم (أمران، متوافقان مع `ugrep` و`grep` GNU)

> الأمر الشائع القديم كان يفشل على `ugrep` (خطأ `empty subexpression`). الأمران أدناه مُختبَران ويعملان
> على الجهازين، ويتعاملان مع البادئات (`file:`) والسالب (`-ml-`) دون إيجابيات كاذبة.
>
> **بدّل `resources/views/` بمجلد قوالبك:** `resources/views` (Laravel)، أو `src` (React/Vue)،
> أو `app`/`components`… أو `.` لفحص المشروع كله.

**أمر (أ) — أصناف لها بديل منطقي (نتيجة فارغة = سليم؛ أي سطر → حوّله حسب الجدول 1):**

```bash
grep -rnE '(^|[^a-zA-Z-])-?((ml|mr|pl|pr)-|(ml|mr)-auto|scroll-(ml|mr|pl|pr)-|float-(left|right)|clear-(left|right)|text-(left|right)|(left|right)-|rounded-(l|r|tl|tr|bl|br)([^a-zA-Z]|$)|border-(l|r)([^a-zA-Z]|$))' resources/views/
```

**أمر (ب) — أصناف بلا بديل منطقي (كل سطر يظهر يجب أن يقابله متغيّر `rtl:` — راجعه يدوياً حسب الجدول 2):**

```bash
grep -rnE '(^|[^a-zA-Z-])-?(origin-((top|bottom)-)?(left|right)|translate-x-|skew-x-|bg-(left|right)|object-(left|right))' resources/views/
```

أو ببساطة اطلب من مساعدك البرمجي: «شغّل أمرَي فحص RTL في هذا الدليل وحوّل أي مخالفة».

---

## معيار النجاح (للمراجعة قبل التسليم)

- [ ] `<html>` تحمل `lang="ar" dir="rtl"` في التخطيط الجذري لكل صفحة.
- [ ] أمر الطبقة 3 (أ) يعيد نتيجة فارغة.
- [ ] كل سطر يظهره أمر الطبقة 3 (ب) له متغيّر `rtl:` مقابل.
- [ ] ملف تعليمات مساعدك البرمجي يحتوي قسم قواعد RTL (الطبقة 1).
- [ ] الأسهم والأيقونات الاتجاهية تشير للاتجاه الصحيح بالعربية.
- [ ] الأرقام/الروابط/المقاطع اللاتينية معزولة بـ `dir="ltr"` أو `<bdi>`.
- [ ] (اختياري) بدّل `dir` إلى `ltr` مؤقتاً — يجب أن ينقلب التخطيط كاملاً دون أي كسر.

---

## شكر ومصدر

فكرة هذا الدليل ونهج الطبقة الآلية مبنيّان على عمل **عمّار العقّاد**:

- المقالة: [ESLint plugin for Tailwind RTL](https://ammar.codes/posts/eslint-tailwind-rtl/)
- الإضافة مفتوحة المصدر: [`eslint-plugin-tailwind-rtl`](https://github.com/AmmarCodes/eslint-plugin-tailwind-rtl)

يُنشر هذا الدليل تحت رخصة **[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.ar)** — لك حرية المشاركة والتعديل مع حفظ النسبة.
