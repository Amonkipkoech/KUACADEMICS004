report 60009 "ELECT-Voter Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/ELECT-Voter Register.rdl';

    dataset
    {
        dataitem(ElectPollingCenters; 60008)
        {
            DataItemTableView = SORTING("Election Code", "Polling Center Code")
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
            column(ElectralCode; ElectPollingCenters."Election Code")
            {
            }
            column(ElectralDistrict; ElectPollingCenters."Electral District")
            {
            }
            column(ElectPollingCenter; ElectPollingCenters."Polling Center Code")
            {
            }
            column(ElectPositionCode; '')
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
            dataitem(ElectVoterRegister; 60002)
            {
                DataItemLink = "Election Code" = FIELD("Election Code"),
                               "Electral District" = FIELD("Electral District"),
                               "Polling Center Code" = FIELD("Polling Center Code");
                DataItemTableView = SORTING("Election Code", "Voter No.")
                                    ORDER(Ascending);
                column(VoterNo; ElectVoterRegister."Voter No.")
                {
                }
                column(VoterNames; ElectVoterRegister."Voter Names")
                {
                }
                column(ELigibleVoter; ElectVoterRegister.Eligible)
                {
                }
                column(ELigibleTOVie; ElectVoterRegister."Manual Eligibility to Contest")
                {
                }
                column(seq; seq)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    seq := seq + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(seq);
                CLEAR(Schls);
                CLEAR(Deps);
                CLEAR(Camps);
                ELECTElectionsHeader.RESET;
                ELECTElectionsHeader.SETRANGE("Election Code", ElectPollingCenters."Election Code");
                IF ELECTElectionsHeader.FIND('-') THEN BEGIN
                END;


                // // IF ElectPositions."Election Code"='' THEN ElectPositions."Election Code":='- - -';
                // // IF ElectPositions."Electral District"='' THEN ElectPositions."Electral District":='- - -';
                // // IF ElectPositions."Position Category"='' THEN ElectPositions."Position Category":='- - -';
                // // IF ElectPositions."School Code"='' THEN ElectPositions."School Code":='- - -';
                // // IF ElectPositions."Department Code"='' THEN ElectPositions."Department Code":='- - -';
                // // IF ElectPositions."Campus Code"='' THEN ElectPositions."Campus Code":='- - -';
                // //
                // // DimensionValue.RESET;
                // // DimensionValue.SETRANGE(Code,ElectPositions."School Code");
                // // IF DimensionValue.FIND('-') THEN Schls:=DimensionValue.Name
                // // ELSE Schls:= ElectPositions."School Code";
                // //
                // //
                // // DimensionValue.RESET;
                // // DimensionValue.SETRANGE(Code,ElectPositions."Department Code");
                // // IF DimensionValue.FIND('-') THEN Deps:=DimensionValue.Name
                // // ELSE Deps:=ElectPositions."Department Code";
                // //
                // //
                // // DimensionValue.RESET;
                // // DimensionValue.SETRANGE(Code,ElectPositions."Campus Code");
                // // IF DimensionValue.FIND('-') THEN Camps:=DimensionValue.Name
                // // ELSE Camps:=ElectPositions."Campus Code";
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

