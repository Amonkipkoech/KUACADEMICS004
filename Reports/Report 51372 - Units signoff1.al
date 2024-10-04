report 51372 "Units signoff1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Units signoff1.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            RequestFilterFields = "Code";
            column(Programme_Description; Description)
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(Programme_Faculty; Faculty)
            {
            }
            column(UPPERCASE_USERID_; UPPERCASE(USERID))
            {
            }
            column(coursereg_Stage; coursereg.Stage)
            {
            }
            column(COURSE_REGISTRATIONCaption; COURSE_REGISTRATIONCaptionLbl)
            {
            }
            column(SIGNATURECaption; SIGNATURECaptionLbl)
            {
            }
            column(COURSES_REGISTEREDCaption; COURSES_REGISTEREDCaptionLbl)
            {
            }
            column(STUDENT_NO___NAMECaption; STUDENT_NO___NAMECaptionLbl)
            {
            }
            column(Programme_Code; Code)
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "Student Programme" = FIELD(Code);
                DataItemTableView = WHERE(Status = CONST(Current));
                RequestFilterFields = "No.";
                column(Customer_No_; "No.")
                {
                }
                column(Customer_Student_Programme; "Student Programme")
                {
                }
                dataitem("ACA-Course Registration"; "ACA-Course Registration")
                {
                    DataItemLink = "Student No." = FIELD("No.");
                    DataItemTableView = SORTING("Student No.");
                    RequestFilterFields = Stage, Semester;
                    column(Course_Registration__Student_No__; "Student No.")
                    {
                    }
                    column(StudentU; StudentU)
                    {
                    }
                    column(Sname; Sname)
                    {
                    }
                    column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
                    {
                    }
                    column(Course_Registration_Programme; Programmes)
                    {
                    }
                    column(Course_Registration_Semester; Semester)
                    {
                    }
                    column(Course_Registration_Register_for; "Register for")
                    {
                    }
                    column(Course_Registration_Stage; Stage)
                    {
                    }
                    column(Course_Registration_Unit; Unit)
                    {
                    }
                    column(Course_Registration_Student_Type; "Student Type")
                    {
                    }
                    column(Course_Registration_Entry_No_; "Entry No.")
                    {
                    }
                    dataitem("ACA-Student Units"; "ACA-Student Units")
                    {
                        DataItemLink = "Student No." = FIELD("Student No."),
                                       Stage = FIELD(Stage);
                    }

                    trigger OnAfterGetRecord()
                    begin
                        /*
                        coursereg.SETRANGE(coursereg."Student No.",cust."No.");
                        IF coursereg.FIND('+') THEN BEGIN
                          regtid:=coursereg."Reg. Transacton ID";
                        END;
                        
                        studentunitrec.SETRANGE(studentunitrec."Student No.","Course Registration"."Student No.");
                        //studentunitrec.SETRANGE(studentunitrec."Reg. Transacton ID",regtid);
                        studentunitrec.SETRANGE(studentunitrec.Stage,coursereg.Stage);
                        
                         StudentU:='';
                        IF studentunitrec.FIND('-') THEN BEGIN
                          REPEAT
                            StudentU:=StudentU+'  '+studentunitrec.Unit;
                          UNTIL studentunitrec.NEXT=0;
                        END;
                        
                        cust.RESET;
                        cust.SETRANGE(cust."No.","Course Registration"."Student No.");
                        IF cust.FIND('-') THEN  BEGIN
                          Sname:=cust.Name;
                        END;
                        */

                    end;

                    trigger OnPreDataItem()
                    begin
                        coursereg.SETRANGE(coursereg."Student No.", cust."No.");
                        IF coursereg.FIND('+') THEN BEGIN
                            regtid := coursereg."Reg. Transacton ID";
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    coursereg.SETRANGE(coursereg."Student No.", cust."No.");


                    studentunitrec.SETRANGE(studentunitrec."Student No.", "No.");

                    studentunitrec.SETRANGE(studentunitrec.Stage, YXSX);

                    StudentU := '';
                    IF studentunitrec.FIND('-') THEN BEGIN
                        REPEAT
                            StudentU := StudentU + '  ' + studentunitrec.Unit;
                        UNTIL studentunitrec.NEXT = 0;
                    END;

                    cust.RESET;
                    cust.SETRANGE(cust."No.", "No.");
                    IF cust.FIND('-') THEN BEGIN
                        Sname := cust.Name;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Dimrec.RESET;
                Dimrec.SETRANGE(Dimrec.Code, "ACA-Programme".Faculty);
                IF Dimrec.FIND('-') THEN BEGIN
                    Faculty := Dimrec.Name;
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF YXSX = '' THEN
                    ERROR('Please enter the Year');
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
        StudentU: Text[300];
        studentunitrec: Record 61549;
        cust: Record 18;
        Sname: Text[150];
        coursereg: Record 61532;
        regtid: Code[20];
        Yearfilter: Text[30];
        Faculty: Text[150];
        Dimrec: Record 349;
        sem: Text[150];
        YXSX: Text[30];
        COURSE_REGISTRATIONCaptionLbl: Label 'COURSE REGISTRATION';
        SIGNATURECaptionLbl: Label 'SIGNATURE';
        COURSES_REGISTEREDCaptionLbl: Label 'COURSES REGISTERED';
        STUDENT_NO___NAMECaptionLbl: Label 'STUDENT NO & NAME';
}

