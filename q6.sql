/* Set-up */
CLEAR COLUMNS
SET VERIFY OFF
SET NUMWIDTH 4

/* Prompting the user and validating choice */
PROMPT Enter co-ordinates of your desired search area
ACCEPT MINX NUMBER PROMPT 'Min X: '
ACCEPT MAXX NUMBER PROMPT 'Max X: '
ACCEPT MINY NUMBER PROMPT 'Min Y: '
ACCEPT MAXY NUMBER PROMPT 'Max Y: '

/* Begin output report */
SPOOL q6_output.txt

/* Formatting of report */
TTITLE LEFT 'Fields in the area (&MINX,&MINY) to (&MAXX,&MAXY)'  SKIP 2
COLUMN FIELD_ID HEADING 'Field ID(s) ' FORMAT 9
SET UNDERLINE =
SET PAGESIZE 300

/* Start of query */
SELECT A.FIELD_ID
FROM GISTEACH.FIELDS A
WHERE A.FIELD_ID IN
/* Subquery 1 */
/* Checking for Field ID fully contained */
(
  SELECT B.FIELD_ID
FROM GISTEACH.FIELDS B
WHERE B.LOWX >= &MINX
AND B.HIX <= &MAXX
AND B.LOWY >= &MINY
AND B.HIY <= &MAXY
)
OR A.FIELD_ID IN
/* Subquery 2 */
/* Checking for Field ID of surrounding
or ones with corner containment */
(
  SELECT D.FIELD_ID
FROM GISTEACH.FIELDS D
/* Bottom overlap */
WHERE &MAXX BETWEEN D.LOWX AND D.HIX
AND (
  &MAXY BETWEEN D.LOWY AND D.HIY
OR &MINY BETWEEN D.LOWY AND D.HIY
)
/* Top overlap */
OR &MINX BETWEEN D.LOWX AND D.HIX
AND (
  &MAXY BETWEEN D.LOWY AND D.HIY
OR &MINY BETWEEN D.LOWY AND D.HIY
)
/* Checking full row/column containment*/
OR (
  D.LOWY BETWEEN &MINY AND &MAXY
AND D.HIY BETWEEN &MINY AND &MAXY
)
OR (
  D.LOWX BETWEEN &MINX AND &MAXX
AND D.HIX BETWEEN &MINX AND &MAXX
)
)
/
/* End of query */
SPOOL OFF
/* End of output */
