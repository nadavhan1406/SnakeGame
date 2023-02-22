# יומן שינויים
# 29.1.23 - יום ראשון
 התחלתי אתמול וזה מה שהספקתי לעשות עד עכשיו
 - לסיים את מסך הבית (אפשר לקשט יותר, אבל כרגע הל עובד)
 - החלטתי שכל ריבוע במשחק הוא 15 על 15 פיקסלים
 - יצרתי פונקציה שמקבלת מרכז ריבוע רצוי וצבע ריבוע רצוי, ויוצרת ריבוע 15 על 15 עם המרכז והצבע שניתנו
 - החלטתי על גבולות של המסך ויצרתי בורדר מסביב ללוח המשחק
 - יצרתי פונקציה שמדפיסה את הניקוד על המסך
 
 מה יש לעשות לשבוע הבא:
 - ליצור לולאת משחק שחוזרת כל 3 עדכונים של המעבד
 - ליצור פונקציה אם אחד ממקשי החצים נלחצו
 - להתחיל לעבוד על הנחש עצמו
 # 5.2.23 - יום ראשון
 התקדמתי קצת יותר מהר ממה שחשבתי, אבל עדיין הזמן לא עובד לי. ניסיתי לגשת למונה ולא עבד, ניסיתי עם פסיקה לעשות לולאה עם דיליי, ועדיין לא עבד. הקטנתי כל ריבוע על המסך ל11 על 11. (כשאני כותב x וy אני מתכוון למרכז של הריבוע)
 - יצרתי נחש, שזה כולל הרבה דברים: 
   - משתנה של הx של הראש
   - משתנה של הy של הראש
   - מערך של הx של שאר הנחש (הכי קרוב לראש הוא ראשון)
   - מערך של הy של שאר הנחש (הכי קרוב לראש הוא ראשון)
   - משתנה של אורך הנחש
 - יצרתי פונקציה שמדפיסה את הנחש (הראש בירוק כהה ושאר הגוף בירוק בהיר)
 - יצרתי פונקציה שעוברת למסך הראשי (אחרי שלוחצים הstart במסך בית)
 - יצרתי פונקציה שלוקחת קלט מהמקלדת (חצים) ולפי זה משנה את המשתנה dir (כיוון)
 - יצרתי פונקציה שלפי dir מזיזה את הנחש
 - יצרתי פונקציה שבודקת אם הראש באחד הקירות או בעצמו. מאוחר יותר הפונקציה גם תבדוק לגבי התפוח

עדכון של אחרי פגישת אמצע:

יאיר אמר לי להסתכל בספר, אז נכנסתי וראיתי שניגשים שם למונה באמצעות es, אז ניסיתי, ועבד לי.

מה יש לי לעשות לשבוע הבא:
- לעשות פונקציה שיוצרת תפוח במקום אקראי על המסך
- להוסיף לפונקציה שבודקת את הראש קוד שבודק אם הראש אוכל את התפוח
- אם הראש אוכל את התפוח, אז התכנית תקרא לפונקציה שיוצרת תפוח חדש, תעלה את הניקוד, ותאריך את הנחש.
- אולי בהמשך גם סאונד
# 9.2.23 - יום חמישי
אוקיי אז התקדמתי בקצב מטורף ואני כעיקרון סיימתי את המשחק.
 - יצרתי פונקציה שלוקחת מהמונה את ה9 ביטים הראשונים, עושה לו xor עם מספר שהגדרתי, ואם זה יוצא מחוץ למסך, או על הנחש (לא בדיוק ככה, אבל פחות או יותר), אז 
התפוח יהיה מאחורי הנחש
 - יצרתי פונקציה שמאפסת את כל המשתנים לערכים ההתחלתיים
 - יצרתי משתנה isApple שבתוכו יש 0 או 1 בהתאם לאם התפוח נאכל באותה איטרציה
 - העתקתי את הפונקציה שמדפיסה ריבוע 11 על 11, ושיניתי ל9 על 9. כלומר יצרתי פונקציה שמדפיסה ריבוע 9 על 9 בשביל התפוח
 - יצרתי פונקציה שמדפיסה את התפוח
 - עשיתי פונקציה שעושה מסך סיום (כמו המסך פתיחה, רק שכיתוב שונה, ומודפס הניקוד)
 - עדכנתי את הפונקציה שבודקת את הראש, ושמה 0 או 1 בisApple.
 - אם הפונקציה מחזירה בisApple = true, אז הפונקציה שיוצרת את התפוח מופעלת, הנחש מתארך, שזה כולל להוסיף למשתנה אורך של הנחש, מדפיסה ומוסיף למערך של הנחש את המיקום של הזנב.
 
מה יש לי לעשות לשבוע הבא:
- לתקן באג שהתפוח מזדמן על הנחש
- מסך ניצחון
- להוסיף סאונד
# 12.2.23 - יום ראשון
מסתבר שהיה כתוב 1 במקום 2, וזה גרם לזה שהתפוח הזדמן על הנחש לפעמים, וגם יותר פעמים מאחורי הנחש מתי שהוא לא אמור להיות. הוספתי גם סאונד, והוא עובד, אבל רק בדוסבוקס. הסאונד לא עובד בvscode. הנה מה שעשיתי מיום חמישי:
 - יצרתי פונקציה שעושה מסך ניצחון (כמו המסך סיום, רק שכתוב שניצחת), מתי שהאורך של הנחש הוא כל המסך
 - הוספתי סאונד למתי שהנחש אוכל התפוח, ומתי שנחש נפסל
 - תיקנתי את הבאג שהנחש הזדמן על התפוח

מה נשאר לי לעשות:

- קודם כל להתכונן לקורס A, אז כנראה לא יהיה יותר מדי התקדמות השבוע
- לתקן באג שהמשחק נעצר לרגע אחרי שהתפוח נאכל
- להוסיף סאונד ניצחון
# 19.2.23 - יום ראשון
בשבוע האחרון לא ממש עשיתי כלום. חשבתי על איזה סאונד ניצחון, ואני אעשה אותו בהמשך השבוע.
# 21.2.23 - יום שלישי
הבעיה שלי עם הסאונד היה שמתי שהנחש אוכל את התפוח, המשחק נעצר עד שהסאונד נגמר אז היו לי שתי אופציות: לעשות סאונד יותר קצר, או לנסות לשלב את הסאונד בלופ של המשחק.
יש לי בקוד לולאה שסוג של מחכה 3 עדכונים, אז ניצלתי את זה בשביל להשאיר את הסאונד הארוך.
- תיקנתי את זה שהמשחק נעצר לרגע מתי שהנחש אוכל תפוח
- יצרתי פונקציה שלוקחת מערך של צלילים, ומנגנת אותו
- יצרתי מערך של סאונד ניצחון, כלומר יש עכשיו סאונד ניצחון
- מחקתי את הפונקציה שעושה את הסאונד סיום, ויצרתי מערך של סאונד סיום
- שיניתי קצת את הסאונד סיום
- הוספתי אפשרות בקוד לזה שהאורך של הנחש יתחיל ב0 (רק הראש)
- הוספתי בקוד אפשרות "לקצר" את המשחק, בכך שמשנים את האורך הדרוש של הנחש כדי שהמשחק יגמר בניצחון (ככה בדקתי את הסאונד ניצחון)

מה יש לי לעשות:
בתכלס סיימתי הכל, אבל אני יכול לשפץ ולהפוך את המשחק ליותר יפה
