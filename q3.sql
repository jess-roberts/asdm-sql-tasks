/* Set up */
CLEAR COLUMNS

/* Start output of report */
SPOOL q3_output.txt

/* Format report */
TTITLE LEFT 'Q3: Farmers who own above average field sizes' SKIP 2
COLUMN FIELD_ID HEADING 'Field ID ' FORMAT 9
COLUMN OWNER HEADING 'Owner' FORMAT A15
COLUMN AREA HEADING ' Area (sq units)' FORMAT 0.99
SET UNDERLINE =
SET PAGESIZE 300
BREAK ON OWNER

/* Start of query */
SELECT A.OWNER, A.FIELD_ID, A.AREA
FROM GISTEACH.FIELDS A WHERE
A.AREA >
/* Subquery for average */
(
  SELECT AVG(B.AREA) FROM GISTEACH.FIELDS B
)
ORDER BY A.OWNER
/
/* End of query */
SPOOL OFF
/* End of output */
