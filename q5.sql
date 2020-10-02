/* Set up */
CLEAR COLUMNS
SET VERIFY OFF
SET NUMWIDTH 4

/* Prompting the user and validating choice */
PROMPT Enter co-ordinates of your desired search area
ACCEPT MINX NUMBER PROMPT 'Min X: '
ACCEPT MAXX NUMBER PROMPT 'Max X: '
ACCEPT MINY NUMBER PROMPT 'Min Y: '
ACCEPT MAXY NUMBER PROMPT 'Max Y: '

/* Start of output report */
SPOOL q5_output.txt

/* Formatting of report */
TTITLE LEFT 'Q5: Fields in the area (&MINX,&MINY) to (&MAXX,&MAXY)'  SKIP 2
COLUMN FIELD_ID HEADING 'Field ID(s) ' FORMAT 9
SET UNDERLINE =
SET PAGESIZE 300

/*Start of query */
SELECT A.FIELD_ID
FROM GISTEACH.FIELDS A
WHERE A.LOWX >= &MINX
AND A.HIX <= &MAXX
AND A.LOWY >= &MINY
AND A.HIY <= &MAXY
ORDER BY A.FIELD_ID
/
/* End of query */
SPOOL OFF
/* End of output */
