# جدول `Users`

## نظرة عامة

يخزن بيانات الحسابات المستخدمة لتسجيل الدخول والتعريف بالمستخدم. ترتبط كل قيمة `Person_ID` في الحساب بسجل شخص في `Persons`.

**المسار:** `[Gilgamesh.v2].[dbo].[Users]`

## الأعمدة

| العمود | النوع في `Users.sql` | الوصف |
|---|---|---|
| `User_ID` | `INT IDENTITY(1,1)` | معرف داخلي متزايد للحساب. |
| `Person_ID` | `INT NOT NULL` | معرف الشخص المرتبط بالحساب. |
| `UserName` | `NVARCHAR(100) NOT NULL` | اسم المستخدم الفريد. |
| `Avatar` | `NVARCHAR(300) NULL` | رابط الصورة أو مسارها؛ اختياري. |
| `Bio` | `NVARCHAR(250) NULL` | نبذة المستخدم؛ اختيارية. |
| `Email` | `NVARCHAR(100) NOT NULL` | البريد الإلكتروني الفريد. |
| `PasswordHash` | `VARCHAR(256) NOT NULL` | تجزئة كلمة المرور. |
| `UserRule` | `NVARCHAR(30) NOT NULL` | دور الحساب؛ القيمة الافتراضية `user`. |
| `EmailVerifiedAt` | `DATETIME2 NULL` | وقت التحقق من البريد؛ يكون فارغاً قبل التحقق. |

## العلاقات والقيود

- `PK_Users`: المفتاح الأساسي العنقودي (`CLUSTERED`) على `User_ID`.
- `FK_User_Person`: مفتاح أجنبي من `Person_ID` إلى `Persons(Person_ID)`؛ يؤدي حذف سجل الشخص إلى حذف حساب المستخدم المرتبط به (`ON DELETE CASCADE`).
- `UQ_User_Person_ID`: يمنع ربط أكثر من حساب بسجل الشخص نفسه.
- `UQ_Users_Email`: يمنع تكرار البريد الإلكتروني.
- `UQ_Users_UserName`: يمنع تكرار اسم المستخدم.
- `DF_User_Rule`: يضبط `UserRule` افتراضياً على `user`.

## الاستخدام في `SP_ADD_NEW_USER`

ينشئ الإجراء سجل الشخص أولاً، ثم يضيف الحساب مع `Person_ID` واسم المستخدم والنبذة والصورة والبريد وتجزئة كلمة المرور. لا يمرر الإجراء `UserRule` أو `EmailVerifiedAt`، لذا يعتمد على القيمة الافتراضية للدور والقيمة `NULL` لتاريخ التحقق.
