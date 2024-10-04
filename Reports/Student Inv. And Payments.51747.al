/// <summary>
/// Report Student Inv. And Payments (ID 51747).
/// </summary>
report 51747 "Student Inv. And Payments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/StudentInvAndPayments.rdl';

    dataset
    {
        dataitem("ACA-Charge"; 61515)
        {
            column(Charge_code; "ACA-Charge".Code)
            {
            }
            column(Charge_Desc; "ACA-Charge".Description)
            {
            }
            column(GenDate; TODAY)
            {
            }
            column(pict; CompanyInfo.Picture)
            {
            }
            column(datefil; datefil)
            {
            }
            column(startDate; startDate)
            {
            }
            column(endDate; endDate)
            {
            }
            dataitem("Dimension Value"; "Dimension Value")
            {
                DataItemTableView = WHERE("Dimension Code" = FILTER('DEPARTMENT'));
                PrintOnlyIfDetail = true;
                column(deptCode; "Dimension Value".Code)
                {
                }
                column(deptName; "Dimension Value".Name)
                {
                }
                dataitem("ACA-Programme"; "ACA-Programme")
                {
                    DataItemLink = "Department Code" = FIELD(Code);
                    PrintOnlyIfDetail = true;
                    column(ProgCode; "ACA-Programme".Code)
                    {
                    }
                    column(ProgDesc; "ACA-Programme".Description)
                    {
                    }
                    dataitem("ACA-Course Registration"; 61532)
                    {
                        DataItemLink = Programmes = FIELD(Code);
                        PrintOnlyIfDetail = true;
                        column(studNo; "ACA-Course Registration"."Student No.")
                        {
                        }
                        column(StudName; "ACA-Course Registration"."Student Name")
                        {
                        }
                        dataitem("Cust. Ledger Entry"; 21)
                        {
                            DataItemLink = "Customer No." = FIELD("Student No.");
                            DataItemTableView = WHERE(Amount = FILTER(> 0),
                                                      Reversed = FILTER(false));
                            column(DocNo; "Cust. Ledger Entry"."Document No.")
                            {
                            }
                            column(postDate; "Cust. Ledger Entry"."Posting Date")
                            {
                            }
                            column(Amnt; "Cust. Ledger Entry".Amount)
                            {
                            }

                            trigger OnPreDataItem()
                            begin
                                // "Cust. Ledger Entry".reset;
                                "Cust. Ledger Entry".SETFILTER("Cust. Ledger Entry".Description, "ACA-Charge".Description);
                                // if "Cust. Ledger Entry".find('')
                                IF datefil <> '' THEN
                                    "Cust. Ledger Entry".SETFILTER("Cust. Ledger Entry"."Date Filter", '%1..%2', startDate, endDate);
                            end;
                        }

                        trigger OnPreDataItem()
                        begin
                            "ACA-Course Registration".SETFILTER("ACA-Course Registration".Semester, '=%1', sems);
                        end;
                    }
                }
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(startDate; startDate)
                {
                    Caption = 'From Date';
                    ApplicationArea = All;
                }
                field(EndDate; endDate)
                {
                    Caption = 'To Date';
                    ApplicationArea = All;
                }
                field(sems; sems)
                {
                    Caption = 'Semester';
                    TableRelation = "ACA-Semesters".Code;
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        IF compInf.GET() THEN BEGIN
            IF compInf."Last Used date Filter (Inv. 1)" <> 0D THEN startDate := compInf."Last Used date Filter (Inv. 1)";
            IF compInf."Last Used date Filter (Inv. 2)" <> 0D THEN endDate := compInf."Last Used date Filter (Inv. 2)";
            IF compInf."Last Semester Filter" <> '' THEN sems := compInf."Last Semester Filter";
        END;
    end;

    trigger OnPostReport()
    begin
        IF compInf.GET() THEN BEGIN
            IF startDate <> 0D THEN compInf."Last Used date Filter (Inv. 1)" := startDate;
            IF endDate <> 0D THEN compInf."Last Used date Filter (Inv. 2)" := endDate;
            IF sems <> '' THEN compInf."Last Semester Filter" := sems;
            compInf.MODIFY;
        END;
    end;

    trigger OnPreReport()
    begin
        IF ((startDate = 0D) AND (endDate = 0D)) THEN ERROR('Specify the start and/or end date');
        CLEAR(datefil);
        IF ((startDate = 0D) AND (endDate <> 0D)) THEN
            datefil := '..' + FORMAT(endDate)
        ELSE
            IF ((startDate <> 0D) AND (endDate = 0D)) THEN
                datefil := FORMAT(startDate) + '..'
            ELSE
                IF ((startDate <> 0D) AND (endDate <> 0D)) THEN datefil := FORMAT(startDate) + '..' + FORMAT(endDate);

        IF (sems = '') THEN ERROR('Specify the semester.');
        IF CompanyInfo.GET() THEN
            CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
    end;

    var
        header1: Text;
        startDate: Date;
        endDate: Date;
        datefil: Text[120];
        compInf: Record 79;
        CompanyInfo: Record 79;
        acadyear: Code[30];
        sems: Code[30];
}

