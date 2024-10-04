page 68929 "ACA-Std. Data Buffer"
{
    PageType = List;
    SourceTable = "ACA-Student Data Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Counts; Rec.Counts)
                {
                    ApplicationArea = All;
                }
                field("Stud. No."; Rec."Stud. No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field(Updated; Rec.Updated)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field(DOB; Rec.DOB)
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field(School; Rec.School)
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field("Guardian Name"; Rec."Guardian Name")
                {
                    ApplicationArea = All;
                }
                field("Guardian Contact"; Rec."Guardian Contact")
                {
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field("Admission Date"; Rec."Admission Date")
                {
                    ApplicationArea = All;
                }
                field("Courese Duration"; Rec."Courese Duration")
                {
                    ApplicationArea = All;
                }
                field("Study Mode"; Rec."Study Mode")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field(Sponsor; Rec.Sponsor)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(imports)
            {
                Caption = 'Import Student Data';
                Image = ImportCodes;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Import student records?...', FALSE) = FALSE THEN EXIT;
                    XMLPORT.RUN(50803, FALSE, TRUE);
                end;
            }
            action(posts)
            {
                Caption = 'Post/Update Data';
                Image = UpdateDescription;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Update Students Data', TRUE) = FALSE THEN ERROR('Cancelled by user..');
                    CorrectRegNos();
                    pross.OPEN('Processing.....\No: #1#####################');
                    studDataBuff.RESET;
                    studDataBuff.SETRANGE(studDataBuff.Updated, FALSE);
                    IF studDataBuff.FIND('-') THEN BEGIN
                        REPEAT
                            pross.UPDATE(1, studDataBuff."Stud. No." + ': ' + studDataBuff.Name);
                            SLEEP(25);
                            cust.RESET;
                            IF cust.GET(studDataBuff."Stud. No.") THEN BEGIN
                                cust.Name := studDataBuff.Name;
                                cust."Search Name" := studDataBuff.Name;
                                cust.Address := studDataBuff.Address;
                                cust."Address 2" := studDataBuff."Address 2";
                                cust.City := studDataBuff."Address 2";
                                IF STRLEN(studDataBuff.Phone) > 30 THEN
                                    cust."Phone No." := COPYSTR(studDataBuff.Phone, 1, 30);
                                cust."Global Dimension 1 Code" := studDataBuff.Campus;
                                IF studDataBuff.Gender = 'Male' THEN
                                    cust.Gender := 2 ELSE
                                    cust.Gender := 3;
                                cust."ID No" := studDataBuff.ID;
                                // cust."Date Of Birth":=studDataBuff.DOB;
                                cust."E-Mail" := studDataBuff.Email;
                                cust.County := studDataBuff.County;
                                cust."Sponsor Name" := studDataBuff.Sponsor;
                                cust.School := studDataBuff.School;
                                // cust."Study Mode":=studDataBuff."Study Mode";
                                // cust."Course Duration":=studDataBuff."Courese Duration";
                                // cust."Admission Date":=studDataBuff."Admission Date";
                                cust."Global Dimension 2 Filter" := studDataBuff.Department;
                                cust."Current Programme" := studDataBuff.Programme;
                                cust."Current Program" := studDataBuff.Programme;
                                cust.MODIFY;
                                studDataBuff.Updated := TRUE;
                                studDataBuff.MODIFY;
                            END ELSE BEGIN
                                // Insert the record if Missing
                                cust.INIT;
                                cust."No." := studDataBuff."Stud. No.";
                                cust.Name := studDataBuff.Name;
                                cust."Search Name" := studDataBuff.Name;
                                cust.Address := studDataBuff.Address;
                                cust."Address 2" := studDataBuff."Address 2";
                                cust.City := studDataBuff."Address 2";
                                IF STRLEN(studDataBuff.Phone) > 30 THEN
                                    cust."Phone No." := COPYSTR(studDataBuff.Phone, 1, 30);
                                cust."Global Dimension 1 Code" := studDataBuff.Campus;
                                IF studDataBuff.Gender = 'Male' THEN
                                    cust.Gender := 2 ELSE
                                    cust.Gender := 3;
                                cust."ID No" := studDataBuff.ID;
                                cust."Customer Type" := cust."Customer Type"::Student;
                                cust."Customer Posting Group" := 'STUDENT';
                                // cust."Date Of Birth":=studDataBuff.DOB;
                                cust."E-Mail" := studDataBuff.Email;
                                cust.County := studDataBuff.County;
                                cust."Sponsor Name" := studDataBuff.Sponsor;
                                cust.School := studDataBuff.School;
                                // cust."Study Mode":=studDataBuff."Study Mode";
                                // cust."Course Duration":=studDataBuff."Courese Duration";
                                // cust."Admission Date":=studDataBuff."Admission Date";
                                cust."Global Dimension 2 Filter" := studDataBuff.Department;
                                cust."Current Programme" := studDataBuff.Programme;
                                cust."Current Program" := studDataBuff.Programme;
                                cust.INSERT(TRUE);
                                studDataBuff.Updated := FALSE;
                                studDataBuff.MODIFY;
                            END;
                        UNTIL studDataBuff.NEXT = 0;
                    END ELSE BEGIN
                        pross.CLOSE;
                        ERROR('There are no records to be updated...');
                    END;
                    pross.CLOSE;
                    CurrPage.UPDATE(TRUE);
                    MESSAGE('Updated Successfully!');
                end;
            }
        }
    }

    var
        studDataBuff: Record "ACA-Student Data Buffer";
        cust: Record Customer;
        pross: Dialog;

    procedure CorrectRegNos()
    var
        cust1: Record Customer;
        custBuff: Record "ACA-Student Data Buffer";
        replace: Text[100];
        replacewith: Text[100];
        No_Stem: Text[100];
        New_No: Text[100];
        removedString: Text[100];
        counted: Integer;
        NewStem: Text[100];
        stringChar: Code[1];
    begin
        // STEP 1: Remove the first stroke
        IF CONFIRM('Update Records?', TRUE) = FALSE THEN ERROR('Cancelled by user!');

        custBuff.RESET;
        custBuff.SETFILTER(custBuff."Stud. No.", '<>%1', '');
        IF custBuff.FIND('-') THEN BEGIN
            REPEAT
                IF NOT (COPYSTR(custBuff."Stud. No.", 1, 6) = 'REGIST') THEN BEGIN
                    // Clear Variables Here
                    IF STRLEN(custBuff."Stud. No.") > 5 THEN BEGIN
                        CLEAR(No_Stem);
                        CLEAR(removedString);
                        IF NOT cust1.GET(custBuff."Stud. No.") THEN BEGIN
                            IF (COPYSTR(custBuff."Stud. No.", (STRLEN(custBuff."Stud. No.") - 2), 1)) = '/' THEN BEGIN
                                //
                                No_Stem := COPYSTR(custBuff."Stud. No.", 1, (STRLEN(custBuff."Stud. No.") - 3));
                                removedString := COPYSTR(custBuff."Stud. No.", (STRLEN(custBuff."Stud. No.") - 2), 3);
                            END// if /13
                            ELSE
                                IF (COPYSTR(custBuff."Stud. No.", (STRLEN(custBuff."Stud. No.") - 4), 1)) = '/' THEN BEGIN
                                    //
                                    No_Stem := COPYSTR(custBuff."Stud. No.", 1, (STRLEN(custBuff."Stud. No.") - 5));
                                    removedString := COPYSTR(custBuff."Stud. No.", (STRLEN(custBuff."Stud. No.") - 4), 5);
                                END;// if /2013
                            IF No_Stem <> '' THEN BEGIN
                                // create a new stem
                                CLEAR(counted);
                                CLEAR(NewStem);
                                REPEAT
                                BEGIN
                                    CLEAR(stringChar);
                                    counted := counted + 1;
                                    stringChar := COPYSTR(No_Stem, counted, 1);
                                    IF ((stringChar = '/') OR (stringChar = '\')) THEN
                                        stringChar := '-';
                                    NewStem := NewStem + stringChar;
                                END;
                                UNTIL ((counted = STRLEN(No_Stem)) OR (counted > STRLEN(No_Stem)));
                            END; // if No_Stem<>''
                                 // Modify the student No now
                            IF NewStem <> '' THEN BEGIN
                                No_Stem := NewStem;
                                No_Stem := No_Stem + removedString;
                                custBuff."Stud. No." := No_Stem;
                                custBuff.MODIFY;
                                //custBuff.RENAME(custBuff.Programme,No_Stem,custBuff."Academic Year",custBuff.Semester,custBuff."Reg. Trans. No.");
                            END;// if NewStem<>''
                        END;// if not in the student list
                    END;// for repeat
                END;
            UNTIL custBuff.NEXT = 0;
        END;


        // STEP 2: Check & Modify Year from eg. /13 to 2013 and back to /13 for legnth >21
        //progre.OPEN('progress......\#1####################################################################################');
        custBuff.RESET;
        custBuff.SETFILTER(custBuff."Stud. No.", '<>%1', '');
        IF custBuff.FIND('-') THEN BEGIN
            REPEAT
                IF NOT (COPYSTR(custBuff."Stud. No.", 1, 6) = 'REGIST') THEN BEGIN
                    // Clear Variables Here
                    CLEAR(No_Stem);
                    CLEAR(replace);
                    CLEAR(replacewith);
                    CLEAR(New_No);
                    IF NOT cust1.GET(custBuff."Stud. No.") THEN BEGIN
                        // ERROR((COPYSTR(custBuff."Stud. No.",((STRLEN(custBuff."Stud. No."))-2),1)));
                        IF (COPYSTR(custBuff."Stud. No.", ((STRLEN(custBuff."Stud. No.")) - 2), 1)) = '/' THEN BEGIN
                            IF (((STRLEN(custBuff."Stud. No.")) < 19) AND ((STRLEN(custBuff."Stud. No.")) > 5)) THEN BEGIN
                                // Change Year part format
                                replace := COPYSTR(custBuff."Stud. No.", (STRLEN(custBuff."Stud. No.") - 2), 3);
                                replacewith := '/20' + COPYSTR(custBuff."Stud. No.", (STRLEN(custBuff."Stud. No.") - 1), 2);
                                No_Stem := COPYSTR(custBuff."Stud. No.", 1, (STRLEN(custBuff."Stud. No.") - 3));
                                New_No := No_Stem + replacewith;
                                //progre.UPDATE(1,custBuff."Stud. No."+','+replace+','+replacewith+','+No_Stem+','+New_No);
                                //  ERROR(custBuff."Stud. No."+',"+replace+','+replacewith+','+No_Stem+','+New_No);
                                custBuff."Stud. No." := New_No;
                                custBuff.MODIFY;
                                // custBuff.RENAME(custBuff.Programme,New_No,custBuff."Academic Year",custBuff.Semester,custBuff."Reg. Trans. No.");
                            END; //STRLEN(custBuff."Stud. No.")<19
                        END;// if /13
                    END;// Not in the customer List
                END;// Repeat in CustBuff
            UNTIL custBuff.NEXT = 0;
        END;// custBuff.find('-')
            //progre.CLOSE;
        MESSAGE('Data edited Successfully.');
    end;
}

