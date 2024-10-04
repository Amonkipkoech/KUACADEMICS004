report 70094 "ACA-Validate Units"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; 61517)
        {

            trigger OnAfterGetRecord()
            begin
                // // CLEAR(OldUnitCode);
                // // CLEAR(NewUnitCode);
                // // CLEAR(VarcharPart);
                // // CLEAR(IntegerPart);
                // //
                // // IF (STRLEN("ACA-Units/Subjects".Code))>4 THEN BEGIN
                // //  OldUnitCode:="ACA-Units/Subjects".Code;
                // //  VarcharPart:=COPYSTR("ACA-Units/Subjects".Code,1,3);
                // //  IntegerPart:=COPYSTR("ACA-Units/Subjects".Code,(STRLEN("ACA-Units/Subjects".Code)-2),3);
                // //  NewUnitCode:=VarcharPart+' '+IntegerPart;

                /*
                ACAUnitsSubjects.RESET;
                ACAUnitsSubjects.SETRANGE(Code,NewUnitCode);
                ACAUnitsSubjects.SETRANGE("Programme Code","ACA-Units/Subjects"."Programme Code");
                ACAUnitsSubjects.SETRANGE("Stage Code","ACA-Units/Subjects"."Stage Code");
                ACAUnitsSubjects.SETRANGE("Entry No","ACA-Units/Subjects"."Entry No");
                IF ACAUnitsSubjects.FIND('-') THEN BEGIN ACAUnitsSubjects.DELETE;
                  END;
                  */
                // // // // // // "ACA-Units/Subjects"."Corected Unit Code":=NewUnitCode;
                // // // // // // "ACA-Units/Subjects".MODIFY;
                // // // // // // END

            end;

            trigger OnPostDataItem()
            var
                NewCodedUnits: Code[20];
            begin
                /*ACAUnitsSubjects.RESET;
                IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                  REPEAT
                
                    ACAUnitsSubjects2.RESET;
                    ACAUnitsSubjects2.SETRANGE("Programme Code",ACAUnitsSubjects."Programme Code");
                    ACAUnitsSubjects2.SETRANGE(ACAUnitsSubjects2."Corected Unit Code",ACAUnitsSubjects."Corected Unit Code");
                    IF ACAUnitsSubjects2.FIND('-') THEN BEGIN
                      CLEAR(CountedValues);
                        REPEAT
                        CountedValues:=CountedValues+1;
                          ACAUnitsSubjects2."Repeatition Count":=CountedValues;
                          ACAUnitsSubjects2.MODIFY;
                          UNTIL ACAUnitsSubjects2.NEXT =0;
                        END;
                
                    UNTIL ACAUnitsSubjects.NEXT=0;
                  END;
                
                ACAUnitsSubjects3.RESET;
                ACAUnitsSubjects3.SETFILTER("Repeatition Count",'>1');
                IF ACAUnitsSubjects3.FIND('-') THEN BEGIN
                  ACAUnitsSubjects3.DELETEALL;
                  END;
                
                ACAUnitsSubjects4.RESET;
                ACAUnitsSubjects4.SETFILTER("Repeatition Count",'=1');
                IF ACAUnitsSubjects4.FIND('-') THEN BEGIN
                  REPEAT
                    CLEAR(NewCodedUnits);
                    NewCodedUnits:=ACAUnitsSubjects4."Corected Unit Code";
                    IF NewCodedUnits<>'' THEN
                     IF ACAUnitsSubjects4.RENAME(NewCodedUnits,ACAUnitsSubjects4."Programme Code",
                       ACAUnitsSubjects4."Stage Code",ACAUnitsSubjects4."Entry No") THEN BEGIN
                       END;
                    UNTIL ACAUnitsSubjects4.NEXT=0;
                  END;*/

            end;
        }
        dataitem("ACA-Exam Results Buffer 2"; "ACA-Exam Results Buffer 2")
        {

            trigger OnAfterGetRecord()
            begin
                /*CLEAR(OldUnitCode);
                CLEAR(NewUnitCode);
                CLEAR(VarcharPart);
                CLEAR(IntegerPart);
                
                IF (STRLEN("ACA-Exam Results Buffer 2"."Unit Code"))>4 THEN BEGIN
                IF "ACA-Units/Subjects".Code<>'' THEN BEGIN
                  OldUnitCode:="ACA-Exam Results Buffer 2"."Unit Code";
                  VarcharPart:=COPYSTR("ACA-Exam Results Buffer 2"."Unit Code",1,3);
                  IntegerPart:=COPYSTR("ACA-Exam Results Buffer 2"."Unit Code",(STRLEN("ACA-Exam Results Buffer 2"."Unit Code")-2),3);
                  NewUnitCode:=VarcharPart+' '+IntegerPart;
                  END;
                
                "ACA-Exam Results Buffer 2".RENAME("ACA-Exam Results Buffer 2"."Student No.","ACA-Exam Results Buffer 2"."Academic Year"
                ,"ACA-Exam Results Buffer 2".Semester,"ACA-Exam Results Buffer 2".Programme,
                NewUnitCode,"ACA-Exam Results Buffer 2".Stage,"ACA-Exam Results Buffer 2".Intake,"ACA-Exam Results Buffer 2"."Exam Session");
                END;*/

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        VarcharPart: Code[5];
        OldUnitCode: Code[10];
        NewUnitCode: Code[10];
        IntegerPart: Code[10];

        CountedValues: Integer;
}

