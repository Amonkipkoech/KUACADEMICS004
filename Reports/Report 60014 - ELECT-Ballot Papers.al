report 60014 "ELECT-Ballot Papers"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ELECT-Ballot Papers.rdl';

    dataset
    {
        dataitem(ElectPositions; 60001)
        {
            DataItemTableView = SORTING("Election Code", "Position Code", "Position Category", "Electral District", "School Code", "Department Code", "Campus Code")
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            column(ElectHeader; ELECTElectionsHeader."Election Description")
            {
            }
            column(CompNames; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address + ' ' + CompanyInformation."Address 2" + ' ' + CompanyInformation.City)
            {
            }
            column(COmpPhone; CompanyInformation."Phone No." + ' ' + CompanyInformation."Phone No. 2")
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(CompMail; CompanyInformation."Home Page" + ', ' + CompanyInformation."E-Mail")
            {
            }
            column(ElectralCode; ElectPositions."Election Code")
            {
            }
            column(ElectralDistrict; ElectPositions."Electral District")
            {
            }
            column(ElectPositionCategory; ElectPositions."Position Category")
            {
            }
            column(ElectPositionCode; ElectPositions."Position Code")
            {
            }
            column(ElectSchool; Schls)
            {
            }
            column(ElectDepartment; Deps)
            {
            }
            column(ElectCampus; Camps)
            {
            }
            dataitem(ElectCandidates; 60006)
            {
                DataItemLink = "Position Code" = FIELD("Position Code"),
                              "Position Category" = FIELD("Position Category"),
                               "Election Code" = FIELD("Election Code");
                DataItemTableView = SORTING("Election Code", "Candidate No.")
                                    ORDER(Ascending);
                column(CandidateNo; ElectCandidates."Candidate No.")
                {
                }
                column(CandidateNames; ElectCandidates."Candidate Names")
                {
                }
                column(CandPic; ElectCandidates."Photo/Potrait")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(seq);
                    ElectCandidates.CALCFIELDS("Photo/Potrait");
                end;
            }

            trigger OnAfterGetRecord()
            begin

                CLEAR(Schls);
                CLEAR(Deps);
                CLEAR(Camps);
                ELECTElectionsHeader.RESET;
                ELECTElectionsHeader.SETRANGE("Election Code", ElectPositions."Election Code");
                IF ELECTElectionsHeader.FIND('-') THEN BEGIN
                END;


                IF ElectPositions."Election Code" = '' THEN ElectPositions."Election Code" := '- - -';
                IF ElectPositions."Electral District" = '' THEN ElectPositions."Electral District" := '- - -';
                IF ElectPositions."Position Category" = '' THEN ElectPositions."Position Category" := '- - -';
                IF ElectPositions."School Code" = '' THEN ElectPositions."School Code" := '- - -';
                IF ElectPositions."Department Code" = '' THEN ElectPositions."Department Code" := '- - -';
                IF ElectPositions."Campus Code" = '' THEN ElectPositions."Campus Code" := '- - -';

                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, ElectPositions."School Code");
                IF DimensionValue.FIND('-') THEN
                    Schls := DimensionValue.Name
                ELSE
                    Schls := ElectPositions."School Code";


                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, ElectPositions."Department Code");
                IF DimensionValue.FIND('-') THEN
                    Deps := DimensionValue.Name
                ELSE
                    Deps := ElectPositions."Department Code";


                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, ElectPositions."Campus Code");
                IF DimensionValue.FIND('-') THEN
                    Camps := DimensionValue.Name
                ELSE
                    Camps := ElectPositions."Campus Code";
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

    trigger OnInitReport()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
            CompanyInformation.CALCFIELDS(Picture);
        END;
    end;

    var
        CompanyInformation: Record 79;
        ELECTElectionsHeader: Record 60000;
        seq: Integer;
        DimensionValue: Record 349;
        Schls: Text[200];
        Deps: Text[200];
        Camps: Text[200];
}

