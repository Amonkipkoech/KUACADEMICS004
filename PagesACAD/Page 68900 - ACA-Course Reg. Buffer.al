page 68900 "ACA-Course Reg. Buffer"
{
    PageType = List;
    SourceTable = "ACA-Course Registration Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Reg. Trans. No."; Rec."Reg. Trans. No.")
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Settlement Type"; Rec."Settlement Type")
                {
                    ApplicationArea = All;
                }
                field("Student Type"; Rec."Student Type")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                }
                field(Session; Rec.Session)
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Rejected; Rec.Rejected)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Reject Reason"; Rec."Reject Reason")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Post)
            {
                action(ImpCourseReg)
                {
                    Caption = 'Import Course Reg. Buffer';
                    Image = ImportLog;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Import course registration buffer?', TRUE) = FALSE THEN ERROR('Cancelled by user.');
                        cregBuffer.RESET;
                        IF cregBuffer.FIND('-') THEN cregBuffer.DELETEALL;

                        XMLPORT.RUN(60034, FALSE, TRUE);

                        MESSAGE('Imported successfully!');
                    end;
                }
                action(Post_Record)
                {
                    Caption = 'Update Records';
                    Image = PostBatch;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CorrectRegNos();
                        CLEAR(RecCount1);
                        CLEAR(RecCount2);
                        CLEAR(RecCount3);
                        CLEAR(RecCount4);
                        CLEAR(RecCount5);
                        CLEAR(RecCount6);
                        CLEAR(RecCount7);
                        CLEAR(RecCount8);
                        CLEAR(RecCount9);
                        CLEAR(RecCount10);

                        CLEAR(counts);
                        IF CONFIRM('Update Records?', TRUE) = FALSE THEN ERROR('Cancelled by user!');
                        progre.OPEN('Processing Please wait..............\#1###############################################################' +
                        '\#2###############################################################' +
                        '\#3###############################################################' +
                        '\#4###############################################################' +
                        '\#5###############################################################' +
                        '\#6###############################################################' +
                        '\#7###############################################################' +
                        '\#8###############################################################' +
                        '\#9###############################################################' +
                        '\#10###############################################################' +
                        '\#11###############################################################' +
                        '\#12###############################################################' +
                        '\#13###############################################################',
                            RecCount1,
                            RecCount2,
                            RecCount3,
                            RecCount4,
                            RecCount5,
                            RecCount6,
                            RecCount7,
                            RecCount8,
                            RecCount9,
                            RecCount10,
                            Var1,
                            Var1,
                            BufferString
                        );
                        cregBuffer.RESET;
                        CLEAR(Var1);
                        //cregBuffer.SETRANGE(cregBuffer.Posted,FALSE);
                        IF cregBuffer.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                counts := counts + 1;
                                IF counts = 1 THEN
                                    RecCount1 := FORMAT(counts) + '). ' + cregBuffer."Student No." + ': ' + cregBuffer."Student Name"
                                ELSE
                                    IF counts = 2 THEN BEGIN
                                        RecCount2 := FORMAT(counts) + '). ' + cregBuffer."Student No." + ': ' + cregBuffer."Student Name"
                                    END
                                    ELSE
                                        IF counts = 3 THEN BEGIN
                                            RecCount3 := FORMAT(counts) + '). ' + cregBuffer."Student No." + ': ' + cregBuffer."Student Name"
                                        END
                                        ELSE
                                            IF counts = 4 THEN BEGIN
                                                RecCount4 := FORMAT(counts) + '). ' + cregBuffer."Student No." + ': ' + cregBuffer."Student Name"
                                            END
                                            ELSE
                                                IF counts = 5 THEN BEGIN
                                                    RecCount5 := FORMAT(counts) + '). ' + cregBuffer."Student No." + ': ' + cregBuffer."Student Name"
                                                END
                                                ELSE
                                                    IF counts = 6 THEN BEGIN
                                                        RecCount6 := FORMAT(counts) + '). ' + cregBuffer."Student No." + ': ' + cregBuffer."Student Name"
                                                    END
                                                    ELSE
                                                        IF counts = 7 THEN BEGIN
                                                            RecCount7 := FORMAT(counts) + '). ' + cregBuffer."Student No." + ': ' + cregBuffer."Student Name"
                                                        END
                                                        ELSE
                                                            IF counts = 8 THEN BEGIN
                                                                RecCount8 := FORMAT(counts) + '). ' + cregBuffer."Student No." + ': ' + cregBuffer."Student Name"
                                                            END
                                                            ELSE
                                                                IF counts = 9 THEN BEGIN
                                                                    RecCount9 := FORMAT(counts) + '). ' + cregBuffer."Student No." + ': ' + cregBuffer."Student Name"
                                                                END
                                                                ELSE
                                                                    IF counts = 10 THEN BEGIN
                                                                        RecCount10 := FORMAT(counts) + '). ' + cregBuffer."Student No." + ': ' + cregBuffer."Student Name"
                                                                    END ELSE
                                                                        IF counts > 10 THEN BEGIN
                                                                            RecCount1 := RecCount2;
                                                                            RecCount2 := RecCount3;
                                                                            RecCount3 := RecCount4;
                                                                            RecCount4 := RecCount5;
                                                                            RecCount5 := RecCount6;
                                                                            RecCount6 := RecCount7;
                                                                            RecCount7 := RecCount8;
                                                                            RecCount8 := RecCount9;
                                                                            RecCount9 := RecCount10;
                                                                            RecCount10 := FORMAT(counts) + '). ' + cregBuffer."Student No." + ': ' + cregBuffer."Student Name";
                                                                        END;
                                CLEAR(BufferString);
                                BufferString := 'Total Records processed = ' + FORMAT(counts);

                                progre.UPDATE();
                                SLEEP(25);
                                cust.RESET;
                                cust.SETRANGE(cust."No.", cregBuffer."Student No.");
                                IF NOT cust.FIND('-') THEN BEGIN
                                    cregBuffer.Posted := FALSE;
                                    cregBuffer.Rejected := TRUE;
                                    cregBuffer."Reject Reason" := 'Student No. ' + cregBuffer."Student No." + ' Does not exist.';
                                    cregBuffer.MODIFY;
                                END ELSE BEGIN
                                    creg.RESET;
                                    creg.SETRANGE(creg."Student No.", cregBuffer."Student No.");
                                    creg.SETRANGE(creg.Programmes, cregBuffer.Programme);
                                    creg.SETRANGE(creg.Semester, cregBuffer.Semester);
                                    //creg.SETRANGE(creg.Stage,cregBuffer.Stage);
                                    creg.SETRANGE(creg."Academic Year", cregBuffer."Academic Year");
                                    IF NOT creg.FIND('-') THEN BEGIN
                                        creg.INIT;
                                        creg."Reg. Transacton ID" := cregBuffer."Reg. Trans. No.";
                                        creg."Student No." := cregBuffer."Student No.";
                                        IF EVALUATE(openDate, '10032016') THEN
                                            creg."Registration Date" := openDate;
                                        creg.Programmes := cregBuffer.Programme;
                                        creg.Semester := cregBuffer.Semester;
                                        creg."Register for" := creg."Register for"::Stage;
                                        creg.Stage := cregBuffer.Stage;
                                        creg."Student Type" := creg."Student Type"::"Full Time";
                                        creg."Settlement Type" := cregBuffer."Settlement Type";
                                        creg.VALIDATE(creg."Registration Date");
                                        creg.VALIDATE(creg."Settlement Type");
                                        creg."Academic Year" := cregBuffer."Academic Year";
                                        creg.INSERT;
                                        cregBuffer.Posted := TRUE;
                                        cregBuffer.Rejected := FALSE;
                                        cregBuffer."Reject Reason" := '';
                                        cregBuffer.MODIFY;
                                    END ELSE BEGIN
                                        cregBuffer.Posted := FALSE;
                                        cregBuffer.Rejected := TRUE;
                                        cregBuffer."Reject Reason" := 'Already Registered!!';
                                        cregBuffer.MODIFY;
                                    END;
                                END;
                            END;
                            UNTIL cregBuffer.NEXT = 0;
                        END;
                        progre.CLOSE;

                        MESSAGE('Done!');
                        CurrPage.UPDATE;
                    end;
                }
            }
        }
    }

    var
        creg: Record "ACA-Course Registration";
        cregBuffer: Record "ACA-Course Registration Buffer";
        RejReason: Text;
        cust: Record Customer;
        progre: Dialog;
        counts: Integer;
        RecCount1: Text[120];
        RecCount2: Text[120];
        RecCount3: Text[120];
        RecCount4: Text[120];
        RecCount5: Text[120];
        RecCount6: Text[120];
        RecCount7: Text[120];
        RecCount8: Text[120];
        RecCount9: Text[120];
        RecCount10: Text[120];
        BufferString: Text[1024];
        Var1: Code[10];
        openDate: Date;

    procedure CorrectRegNos()
    var
        cust1: Record Customer;
        custBuff: Record "ACA-Course Registration Buffer";
        replace: Text[100];
        replacewith: Text[100];
        No_Stem: Text[100];
        New_No: Text[100];
        removedString: Text[100];
        counted: Integer;
        NewStem: Text[100];
        stringChar: Code[1];
    begin
        /* // STEP 1: Remove the first stroke
      IF CONFIRM('Update Records?',TRUE)=FALSE THEN ERROR('Cancelled by user!');

         custBuff.RESET;
         custBuff.SETFILTER(custBuff."Student No.",'<>%1','');
         IF custBuff.FIND('-') THEN BEGIN
         REPEAT
         BEGIN
         // Clear Variables Here
         IF STRLEN(custBuff."Student No.")>5 THEN BEGIN
         CLEAR(No_Stem);
         CLEAR(removedString);
         IF NOT cust1.GET(custBuff."Student No.") THEN BEGIN
            IF (COPYSTR(custBuff."Student No.",(STRLEN(custBuff."Student No.")-2),1))='/' THEN BEGIN
            //
             No_Stem:=COPYSTR(custBuff."Student No.",1,(STRLEN(custBuff."Student No.")-3));
             removedString:=COPYSTR(custBuff."Student No.",(STRLEN(custBuff."Student No.")-2),3);
            END// if /13
            ELSE IF  (COPYSTR(custBuff."Student No.",(STRLEN(custBuff."Student No.")-4),1))='/' THEN BEGIN
            //
             No_Stem:=COPYSTR(custBuff."Student No.",1,(STRLEN(custBuff."Student No.")-5));
             removedString:=COPYSTR(custBuff."Student No.",(STRLEN(custBuff."Student No.")-4),5);
            END;// if /2013
            IF No_Stem<>'' THEN BEGIN
          // create a new stem
          CLEAR(counted);
          CLEAR(NewStem);
          REPEAT
            BEGIN
            CLEAR(stringChar);
             counted:=counted+1;
             stringChar:=COPYSTR(No_Stem,counted,1);
             IF ((stringChar='/') OR (stringChar='\')) THEN
              stringChar:='-';
             NewStem:=NewStem+stringChar;
            END;
          UNTIL ((counted = STRLEN(No_Stem)) OR (counted > STRLEN(No_Stem)));
          END; // if No_Stem<>''
          // Modify the student No now
          IF NewStem<>'' THEN BEGIN
             No_Stem:=NewStem;
             No_Stem:=No_Stem+removedString;
             custBuff."Student No.":=No_Stem;
             custBuff.MODIFY;
            //custBuff.RENAME(custBuff.Programme,No_Stem,custBuff."Academic Year",custBuff.Semester,custBuff."Reg. Trans. No.");
          END;// if NewStem<>''
         END;// if not in the student list
         END;// for repeat
         END;
         UNTIL custBuff.NEXT=0;
         END;


         // STEP 2: Check & Modify Year from eg. /13 to 2013 and back to /13 for legnth >21
          progre.OPEN('progress......\#1####################################################################################');
         custBuff.RESET;
        custBuff.SETFILTER(custBuff."Student No.",'<>%1','');
         IF custBuff.FIND('-') THEN BEGIN
         REPEAT
         BEGIN
         // Clear Variables Here
         CLEAR(No_Stem);
         CLEAR(replace);
         CLEAR(replacewith);
         CLEAR(New_No);
         IF NOT cust1.GET(custBuff."Student No.") THEN BEGIN
        // ERROR((COPYSTR(custBuff."Student No.",((STRLEN(custBuff."Student No."))-2),1)));
            IF (COPYSTR(custBuff."Student No.",((STRLEN(custBuff."Student No."))-2),1))='/' THEN BEGIN
              IF (((STRLEN(custBuff."Student No."))<19) AND ((STRLEN(custBuff."Student No."))>5)) THEN BEGIN
                // Change Year part format
               replace:=COPYSTR(custBuff."Student No.",(STRLEN(custBuff."Student No.")-2),3);
               replacewith:='/20'+COPYSTR(custBuff."Student No.",(STRLEN(custBuff."Student No.")-1),2);
               No_Stem:=COPYSTR(custBuff."Student No.",1,(STRLEN(custBuff."Student No.")-3));
               New_No:=No_Stem+replacewith;
               progre.UPDATE(1,custBuff."Student No."+','+replace+','+replacewith+','+No_Stem+','+New_No);
             //  ERROR(custBuff."Student No."+',"+replace+','+replacewith+','+No_Stem+','+New_No);

             custBuff."Student No.":=New_No;
             custBuff.MODIFY;
           // custBuff.RENAME(custBuff.Programme,New_No,custBuff."Academic Year",custBuff.Semester,custBuff."Reg. Trans. No.");
              END; //STRLEN(custBuff."Student No.")<19
            END;// if /13
         END;// Not in the customer List
         END;// Repeat in CustBuff
         UNTIL custBuff.NEXT=0;
         END;// custBuff.find('-')
        progre.CLOSE;
      MESSAGE('Data edited Successfully.');*/

    end;
}

