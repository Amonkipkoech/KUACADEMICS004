report 50058 "ACA-Student Balances Per Prog."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ACA-Student Balances Per Prog..rdl';

    dataset
    {
        dataitem(Customer; 18)
        {
            CalcFields = Balance;
            DataItemTableView = WHERE("Customer Posting Group" = FILTER('STUDENT'),
                                      Balance = FILTER(> 0));
            RequestFilterFields = "Global Dimension 1 Code";
            column(CompName; CompanyInformation.Name)
            {
            }
            column(Addresses; CompanyInformation.Address + ', ' + CompanyInformation."Address 2" + ', ' + CompanyInformation.City)
            {
            }
            column(Phone; CompanyInformation."Phone No." + '/' + CompanyInformation."Phone No. 2")
            {
            }
            column(Pics; CompanyInformation.Picture)
            {
            }
            column(Mails; CompanyInformation."E-Mail" + '/' + CompanyInformation."Home Page")
            {
            }
            column(CustNo; Customer."No.")
            {
            }
            column(Balance; Customer.Balance)
            {
            }
            column(CustName; Customer.Name)
            {
            }
            column(SchCode; Schools.Code)
            {
            }
            column(SchName; Schools.Name)
            {
            }
            column(CompCode; Campus.Code)
            {
            }
            column(CampName; Campus.Name)
            {
            }
            column(CourseStage; ACACourseRegistration.Stage)
            {
            }
            column(ProgCode; ACAProgramme.Code)
            {
            }
            column(ProgDesc; ACAProgramme.Description)
            {
            }
            column(ProgCat; ProgCat)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Campus.RESET;
                Campus.SETRANGE(Code, Customer."Global Dimension 1 Code");
                IF Campus.FIND('-') THEN;
                ACACourseRegistration.RESET;
                ACACourseRegistration.SETRANGE("Student No.", Customer."No.");
                ACACourseRegistration.SETRANGE(Reversed, FALSE);
                ACACourseRegistration.SETFILTER(Programmes, '<>%1', '');
                IF ProgCat = ProgCat::"Certificate " THEN BEGIN
                    ACACourseRegistration.SETRANGE("Programme Category", ACACourseRegistration."Programme Category"::"Certificate ")
                END ELSE
                    IF ProgCat = ProgCat::"Course List" THEN BEGIN
                        ACACourseRegistration.SETRANGE("Programme Category", ACACourseRegistration."Programme Category"::"Course List")
                    END ELSE
                        IF ProgCat = ProgCat::Diploma THEN BEGIN
                            ACACourseRegistration.SETRANGE("Programme Category", ACACourseRegistration."Programme Category"::Diploma)
                        END ELSE
                            IF ProgCat = ProgCat::Postgraduate THEN BEGIN
                                ACACourseRegistration.SETRANGE("Programme Category", ACACourseRegistration."Programme Category"::Postgraduate)
                            END ELSE
                                IF ProgCat = ProgCat::Professional THEN BEGIN
                                    ACACourseRegistration.SETRANGE("Programme Category", ACACourseRegistration."Programme Category"::Professional)
                                END ELSE
                                    IF ProgCat = ProgCat::Undergraduate THEN BEGIN
                                        ACACourseRegistration.SETRANGE("Programme Category", ACACourseRegistration."Programme Category"::Undergraduate)
                                    END;
                IF ACACourseRegistration.FIND('+') THEN BEGIN
                    ACACourseRegistration.CALCFIELDS("Programme Category");
                    ACAProgramme.RESET;
                    ACAProgramme.SETRANGE(Code, ACACourseRegistration.Programmes);
                    IF ACAProgramme.FIND('-') THEN BEGIN
                        Schools.RESET;
                        Schools.SETRANGE(Code, ACAProgramme."School Code");
                        IF Schools.FIND('-') THEN BEGIN
                        END;
                    END;
                END ELSE
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                //IF ProgCat<>ProgCat::" " THEN BEGIN
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Fils)
                {
                    Caption = 'Filters';
                    field(ProgsCat; ProgCat)
                    {
                        Caption = 'Programme Category';
                        ApplicationArea = All;
                    }
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
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        ACAProgramme: Record 61511;
        ACACourseRegistration: Record 61532;
        Campus: Record 349;
        Schools: Record 349;
        CompanyInformation: Record 79;
        ProgCat: Option " ","Certificate ",Diploma,Bachelor,Postgraduate,"Postgraduate Diploma",Masters,Doctorate,"Course List",Undergraduate,Professional;
}
