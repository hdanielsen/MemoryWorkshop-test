
/*------------------------------------------------------------------------
    File        : generateGetTests.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : hdaniels
    Created     : Sun Aug 02 09:03:48 EDT 2026
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

block-level on error undo, throw.
define variable oTestGen as TestGenerator  no-undo.

oTestGen = new TestGenerator().
oTestGen:Generate().