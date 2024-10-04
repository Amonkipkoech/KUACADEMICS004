report 51369 "Exam Card Label1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Exam Card Label1.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "Programme Filter", "Stage Filter", "Semester Filter", "Balance (LCY)", "No.", Status;
            column(Customer_No_; "No.")
            {
            }
            column(Customer_Programme_Filter; "Programme Filter")
            {
            }
            column(Customer_Stage_Filter; "Stage Filter")
            {
            }
            column(Customer_Semester_Filter; "Semester Filter")
            {
            }
            dataitem("ACA-Course Registration"; "ACA-Course Registration")
            {
                DataItemLink = "Student No." = FIELD("No."),
                               Programmes = FIELD("Programme Filter"),
                               Stage = FIELD("Stage Filter"),
                               Semester = FIELD("Semester Filter");
                DataItemTableView = SORTING("Student No.");
                MaxIteration = 1;
                RequestFilterFields = "Student No.";
                column(Addr_1__1_; Addr[1] [1])
                {
                }
                column(Addr_1__2_; Addr[1] [2])
                {
                }
                column(Addr_1__3_; Addr[1] [3])
                {
                }
                column(Addr_2__1_; Addr[2] [1])
                {
                }
                column(Addr_2__2_; Addr[2] [2])
                {
                }
                column(Addr_2__3_; Addr[2] [3])
                {
                }
                column(Addr_1__4_; Addr[1] [4])
                {
                }
                column(Addr_1__4__Control1102760007; Addr[1] [4])
                {
                }
                column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
                {
                }
                column(Course_Registration_Student_No_; "Student No.")
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

                trigger OnAfterGetRecord()
                begin
                    RecordNo := RecordNo + 1;
                    ColumnNo := ColumnNo + 1;

                    /*
                    Cust.RESET;
                    Sname:='';
                    Cust.SETRANGE(Cust."No.","Course Registration"."Student No.");
                    IF Cust.FIND('-') THEN BEGIN
                      Sname:=Cust.Name;
                    END;
                    */
                    progrec.RESET;
                    Programmedesc := '';
                    progrec.SETRANGE(progrec.Code, "ACA-Course Registration".Programmes);
                    IF progrec.FIND('-') THEN BEGIN
                        Programmedesc := progrec.Description;
                    END;


                    "ACA-Course Registration".CALCFIELDS("ACA-Course Registration".Faculty);

                    dimrec.RESET;
                    DimDesc := '';
                    dimrec.SETRANGE(dimrec.Code, "ACA-Course Registration".Faculty);
                    IF dimrec.FIND('-') THEN BEGIN
                        DimDesc := dimrec.Name;
                    END;


                    Addr[ColumnNo] [1] := FORMAT("Student No.");

                    Cust.RESET;
                    Sname := '';
                    Cust.SETRANGE(Cust."No.", "ACA-Course Registration"."Student No.");
                    IF Cust.FIND('-') THEN BEGIN
                        Sname := Cust.Name;
                    END;


                    Addr[ColumnNo] [2] := FORMAT(DimDesc);
                    Addr[ColumnNo] [3] := FORMAT(Programmedesc);
                    Addr[ColumnNo] [4] := FORMAT(Sname);

                    COMPRESSARRAY(Addr[ColumnNo]);



                    IF RecordNo = NoOfRecords THEN BEGIN
                        FOR i := ColumnNo + 1 TO NoOfColumns DO
                            CLEAR(Addr[i]);
                        ColumnNo := 0;
                    END ELSE BEGIN
                        IF ColumnNo = NoOfColumns THEN
                            ColumnNo := 0;
                    END;

                end;

                trigger OnPreDataItem()
                begin
                    NoOfRecords := COUNT;
                    NoOfColumns := 2;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Customer.CALCFIELDS(Customer."Student Programme");
                //Customer."Programme Filter"
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
        Addr: array[2, 4] of Text[250];
        NoOfRecords: Integer;
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        i: Integer;
        Sname: Text[150];
        Cust: Record 18;
        dimrec: Record 349;
        DimDesc: Text[150];
        Programmedesc: Text[150];
        progrec: Record 61511;
}

