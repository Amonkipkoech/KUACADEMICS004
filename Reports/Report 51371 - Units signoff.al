report 51371 "Units signoff"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Units signoff.rdl';

    dataset
    {
        dataitem("ACA-Programme"; "ACA-Programme")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code";
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(USERID; USERID)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Programme_Description; Description)
            {
            }
            column(Programme_Code; Code)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Course_RegistrationCaption; Course_RegistrationCaptionLbl)
            {
            }
            column(Course_Registration__Student_No__Caption; "ACA-Course Registration".FIELDCAPTION("Student No."))
            {
            }
            column(SignatureCaption; SignatureCaptionLbl)
            {
            }
            column(Units_RegisteredCaption; Units_RegisteredCaptionLbl)
            {
            }
            dataitem("ACA-Course Registration"; "ACA-Course Registration")
            {
                DataItemLink = Programmes = FIELD(Code);
                DataItemTableView = SORTING("Student No.");
                PrintOnlyIfDetail = true;
                RequestFilterFields = "Student No.", Stage, Programmes, Semester;
                column(Course_Registration__Student_No__; "Student No.")
                {
                }
                column(StudentU; StudentU)
                {
                }
                column(Sname; Sname)
                {
                }
                column(HS; HS)
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
                dataitem(Customer; Customer)
                {
                    DataItemLink = "No." = FIELD("Student No.");
                    RequestFilterFields = "No.", Status, "Balance (LCY)";

                    trigger OnAfterGetRecord()
                    begin
                        HS := HS + 1;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    coursereg.SETRANGE(coursereg."Student No.", cust."No.");
                    IF coursereg.FIND('+') THEN BEGIN
                        regtid := coursereg."Reg. Transacton ID";
                    END;

                    studentunitrec.SETRANGE(studentunitrec."Student No.", "ACA-Course Registration"."Student No.");
                    //studentunitrec.SETRANGE(studentunitrec."Reg. Transacton ID",regtid);
                    studentunitrec.SETRANGE(studentunitrec.Stage, coursereg.Stage);

                    StudentU := '';
                    IF studentunitrec.FIND('-') THEN BEGIN
                        REPEAT
                            StudentU := StudentU + '  ' + studentunitrec.Unit;
                        UNTIL studentunitrec.NEXT = 0;
                    END;

                    cust.RESET;
                    cust.SETRANGE(cust."No.", "ACA-Course Registration"."Student No.");
                    IF cust.FIND('-') THEN BEGIN
                        Sname := cust.Name;
                    END;
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
                HS := 0;
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
        HS: Integer;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Course_RegistrationCaptionLbl: Label 'Course Registration';
        SignatureCaptionLbl: Label 'Signature';
        Units_RegisteredCaptionLbl: Label 'Units Registered';
}

