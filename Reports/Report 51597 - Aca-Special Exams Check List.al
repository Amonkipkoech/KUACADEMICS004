report 51597 "Aca-Special Exams Check List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Aca-Special Exams Check List.rdl';

    dataset
    {
        dataitem("Aca-Special Exams Details"; "Aca-Special Exams Details")
        {
            DataItemTableView = WHERE(Programme = FILTER(<> ''),
                                      "Current Academic Year" = FILTER(<> ''),
                                      "Unit Code" = FILTER(<> ''));
            RequestFilterFields = Programme, "Academic Year", "Unit Code";
            column(AcadYear; "Aca-Special Exams Details"."Academic Year")
            {
            }
            column(Semz; "Aca-Special Exams Details".Semester)
            {
            }
            column(Esession; "Aca-Special Exams Details"."Exam Session")
            {
            }
            column(stdNo; "Aca-Special Exams Details"."Student No.")
            {
            }
            column(Stage; "Aca-Special Exams Details".Stage)
            {
            }
            column(Progs; "Aca-Special Exams Details".Programme)
            {
            }
            column(StudUnitCode; "Aca-Special Exams Details"."Unit Code")
            {
            }
            column(Catgry; "Aca-Special Exams Details".Catogory)
            {
            }
            column(Caca; "Aca-Special Exams Details"."Current Academic Year")
            {
            }
            column(status; "Aca-Special Exams Details".Status)
            {
            }
            column(UnitName; "Aca-Special Exams Details"."Unit Description")
            {
            }
            column(CSem; "Aca-Special Exams Details"."Current Semester")
            {
            }
            column(Name1; CompanyInformation.Name)
            {
            }
            column(Name2; CompanyInformation."Name 2")
            {
            }
            column(Address; CompanyInformation.Address)
            {
            }
            column(Adress2; CompanyInformation."Address 2")
            {
            }
            column(City; CompanyInformation.City)
            {
            }
            column(Phone; CompanyInformation."Phone No.")
            {
            }
            column(Phone2; CompanyInformation."Phone No. 2")
            {
            }
            column(logo; CompanyInformation.Picture)
            {
            }
            column(Emails; CompanyInformation."E-Mail")
            {
            }
            column(homep; CompanyInformation."Home Page")
            {
            }
            column(sno; sno)
            {
            }
            column(progName; progName)
            {
            }
            column(studName; studName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                programmes.RESET;
                programmes.SETRANGE(Code, "Aca-Special Exams Details".Programme);
                IF programmes.FIND('-') THEN BEGIN
                    progName := programmes.Description;
                END;
                cust.RESET;
                cust.SETRANGE("No.", "Aca-Special Exams Details"."Student No.");
                IF cust.FIND('-') THEN BEGIN
                    studName := cust.Name;
                END;
                sno := sno + 1;
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

    trigger OnPreReport()
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
        sno := 0;
    end;

    var
        CompanyInformation: Record 79;
        sno: Integer;
        progName: Text;
        programmes: Record 61511;
        cust: Record 18;
        studName: Text;
}

