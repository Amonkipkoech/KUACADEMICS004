report 61613 "Transfer Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Transfer Report.rdl';

    dataset
    {
        dataitem(DataItem1; 61612)
        {
            DataItemTableView = WHERE("New Student No" = FILTER(<> ''));
            RequestFilterFields = Semester;
            column(name; compInfo.Name)
            {
            }
            column(address; compInfo.Address)
            {
            }
            column(phone; compInfo."Phone No.")
            {
            }
            column(mail; compInfo."E-Mail")
            {
            }
            column(url; compInfo."Home Page")
            {
            }
            column(logo; compInfo.Picture)
            {
            }
            column(OldNo; "Student No")
            {
            }
            column(SName; Name)
            {
            }
            column(NSno; "New Student No")
            {
            }
            column(NProg; "New Programme")
            {
            }
            column(date; Date)
            {
            }
            column(cprogmme; "Current Programme")
            {
            }
            column(prgName; prgName)
            {
            }
            column(skulName; skulName)
            {
            }
            column(OlNName; OldprgName)
            {
            }
            column(sno; sno)
            {
            }
            column(sem; Semester)
            {
            }

            trigger OnAfterGetRecord()
            begin
                programmes.RESET;
                programmes.SETRANGE(programmes.code, "New Programme");
                IF programmes.FIND('-') THEN BEGIN
                    prgName := programmes.Description;
                    skul.RESET;
                    skul.SETRANGE(Code, programmes."School Code");
                    IF skul.FIND('-') THEN BEGIN
                        skulName := skul.Name;
                    END;
                END;

                programmes.RESET;
                programmes.SETRANGE(Code, "Current Programme");
                IF programmes.FIND('-') THEN BEGIN
                    OldprgName := programmes.Description;
                END;

                sno := sno + 1;
            end;

            trigger OnPreDataItem()
            begin
                //CONFIRM(Semester:='' THEN ERROR('The Semester parameter is Missing');
                compInfo.GET();
                compInfo.CALCFIELDS(compinfo.picture);
                sno := 0;
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
        sno: Integer;
}

