/* Set up */
CLEAR COLUMNS

/* Start output report */
SPOOL q1_output.txt

/* Report formatting */
TTITLE LEFT 'Q1: Finds between (4,4) and (10,10)' SKIP 2
COLUMN FIND_ID HEADING 'Find ID ' FORMAT 9
COLUMN NAME HEADING 'Class' FORMAT A9
COLUMN PERIOD HEADING 'Period' FORMAT A9
COLUMN DEPTH HEADING 'Depth ' FORMAT 0.99
COLUMN FIELD_NOTES HEADING 'Field Notes' FORMAT A20 WORD_WRAP
SET UNDERLINE =
SET LINESIZE 100
BREAK ON FIND_ID SKIP 1

/* Start of query */
SELECT A.FIND_ID, B.NAME, B.PERIOD, A.DEPTH, A.FIELD_NOTES
FROM GISTEACH.FINDS A, GISTEACH.CLASS B
WHERE A.TYPE = B.TYPE
AND A.XCOORD BETWEEN 4 AND 10
AND A.YCOORD BETWEEN 4 AND 10
ORDER BY A.FIND_ID
/
/* End of query */
SPOOL OFF
/* End of output */
