report 61612 "Aca-Students Transfer Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Aca-Students Transfer Report.rdl';

    dataset
    {
        dataitem("ACA-Students Transfer"; "ACA-Students Transfer")
        {
            RequestFilterFields = "New Student No", Semester;
            column(OldNo; "ACA-Students Transfer"."Student No")
            {
            }
            column(Name; "ACA-Students Transfer".Name)
            {
            }
            column(NewNo; "ACA-Students Transfer"."New Student No")
            {
            }
            column(NProg; "ACA-Students Transfer"."New Programme")
            {
            }
            column(date; "ACA-Students Transfer".Date)
            {
            }
            column(posted; "ACA-Students Transfer".Posted)
            {
            }
            column(sem; "ACA-Students Transfer".Semester)
            {
            }
            column(Cprog; "ACA-Students Transfer"."Current Programme")
            {
            }
            column(CompNane; compInfo.Name)
            {
            }
            column(CompAddress; compInfo.Address)
            {
            }
            column(CompPhone; compInfo."Phone No.")
            {
            }
            column(CompPic; compInfo.Picture)
            {
            }
            column(CompMail; compInfo."E-Mail")
            {
            }
            column(CompUrl; compInfo."Home Page")
            {
            }
            column(prgName; prgName)
            {
            }
            column(skulName; skulName)
            {
            }
            column(OldPrgName; OldprgName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                programmes.RESET;
                programmes.SETRANGE(Code, "ACA-Students Transfer"."New Programme");
                IF programmes.FIND('-') THEN BEGIN
                    prgName := programmes.Description;
                    skul.RESET;
                    skul.SETRANGE(Code, programmes."School Code");
                    IF skul.FIND('-') THEN BEGIN
                        skulName := skul.Name;
                    END;
                END;

                programmes.RESET;
                programmes.SETRANGE(Code, "ACA-Students Transfer"."Current Programme");
                IF programmes.FIND('-') THEN BEGIN
                    OldprgName := programmes.Description;
                END;
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
        compInfo: Record 79;
        programmes: Record 61511;
        skul: Record 349;
        prgName: Text;
        skulName: Text;
        OldprgName: Text;
}

