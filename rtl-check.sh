#!/usr/bin/env bash
#
# rtl-check.sh — يفحص أصناف Tailwind الفيزيائية التي تكسر واجهات RTL (العربية).
# يعمل مع grep (GNU) و ugrep. يعيد رمز خروج 1 عند وجود مخالفات (مناسب لـ CI).
#
# الاستخدام:
#   ./rtl-check.sh [مجلد]
#   ./rtl-check.sh                  # يفحص المجلد الحالي
#   ./rtl-check.sh resources/views  # Laravel / Blade
#   ./rtl-check.sh src              # React / Vue
#
# المرجع الكامل: rtl-guide.md
set -euo pipefail

DIR="${1:-.}"

if [ ! -d "$DIR" ]; then
  echo "خطأ: المجلد غير موجود: $DIR" >&2
  exit 2
fi

# ألوان (تُعطَّل تلقائياً إن لم يكن الخرج طرفية)
if [ -t 1 ]; then
  RED=$'\033[31m'; YEL=$'\033[33m'; GRN=$'\033[32m'; BLD=$'\033[1m'; RST=$'\033[0m'
else
  RED=''; YEL=''; GRN=''; BLD=''; RST=''
fi

EXCLUDES="--exclude-dir=node_modules --exclude-dir=vendor --exclude-dir=.git --exclude-dir=dist --exclude-dir=build --exclude-dir=storage --exclude-dir=public"

# (أ) أصناف فيزيائية لها بديل منطقي → يجب التحويل (رفض صارم).
PATTERN_A='(^|[^a-zA-Z-])-?((ml|mr|pl|pr)-|(ml|mr)-auto|scroll-(ml|mr|pl|pr)-|float-(left|right)|clear-(left|right)|text-(left|right)|(left|right)-|rounded-(l|r|tl|tr|bl|br)([^a-zA-Z]|$)|border-(l|r)([^a-zA-Z]|$))'

# (ب) أصناف بلا بديل منطقي → تحتاج متغيّر rtl:/ltr: (رفض فقط عند غيابه).
PATTERN_B='(^|[^a-zA-Z-])-?(origin-((top|bottom)-)?(left|right)|translate-x-|skew-x-|bg-(left|right)|object-(left|right))'

echo "${BLD}فحص RTL في:${RST} $DIR"
echo

fail=0

a_hits=$(grep -rnE $EXCLUDES "$PATTERN_A" "$DIR" 2>/dev/null || true)
if [ -n "$a_hits" ]; then
  echo "${RED}${BLD}✗ (أ) أصناف فيزيائية لها بديل منطقي — حوّلها (الجدول 1 في rtl-guide.md):${RST}"
  echo "$a_hits" | sed "s/^/  ${RED}•${RST} /"
  echo
  fail=1
fi

# للفحص (ب) نُبلِّغ فقط عن الأسطر التي تفتقر إلى متغيّر rtl:/ltr:.
b_hits=$(grep -rnE $EXCLUDES "$PATTERN_B" "$DIR" 2>/dev/null | grep -vE 'rtl:|ltr:' || true)
if [ -n "$b_hits" ]; then
  echo "${YEL}${BLD}⚠ (ب) أصناف بلا بديل منطقي وبلا متغيّر rtl:/ltr: — أضف مقابلاً اتجاهياً (الجدول 2):${RST}"
  echo "$b_hits" | sed "s/^/  ${YEL}•${RST} /"
  echo
  fail=1
fi

if [ "$fail" -eq 0 ]; then
  echo "${GRN}${BLD}✓ نظيف — لا مخالفات RTL.${RST}"
fi

exit $fail
