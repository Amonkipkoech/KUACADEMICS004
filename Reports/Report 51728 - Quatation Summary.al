report 51728 "Quatation Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Quatation Summary.rdl';

    dataset
    {
        dataitem(DataItem1; 39)
        {
            column(DocumentNo_PurchaseLine; "Document No.")
            {
            }
            column(No_PurchaseLine; "No.")
            {
            }
            column(Description_PurchaseLine; Description)
            {
            }
            column(Description2_PurchaseLine; "Description 2")
            {
            }
            column(UnitofMeasure_PurchaseLine; "Unit of Measure")
            {
            }
            column(Quantity_PurchaseLine; Quantity)
            {
            }
            column(VDesc1; VDesc[1])
            {
            }
            column(VDesc2; VDesc[2])
            {
            }
            column(VDesc3; VDesc[3])
            {
            }
            column(VDesc4; VDesc[4])
            {
            }
            column(VDesc5; VDesc[5])
            {
            }
            column(VDesc6; VDesc[6])
            {
            }
            column(VDesc7; VDesc[7])
            {
            }
            column(VDesc8; VDesc[8])
            {
            }
            column(VDesc9; VDesc[9])
            {
            }
            column(VDesc10; VDesc[10])
            {
            }
            column(VDesc11; VDesc[11])
            {
            }
            column(V1Desc1; VDesc1[1])
            {
            }
            column(V1Desc2; VDesc1[2])
            {
            }
            column(V1Desc3; VDesc1[3])
            {
            }
            column(V1Desc4; VDesc1[4])
            {
            }
            column(V1Desc5; VDesc1[5])
            {
            }
            column(V1Desc6; VDesc1[6])
            {
            }
            column(V1Desc7; VDesc1[7])
            {
            }
            column(V1Desc8; VDesc1[8])
            {
            }
            column(V1Desc9; VDesc1[9])
            {
            }
            column(V1Desc10; VDesc1[10])
            {
            }
            column(VU1; VU[1])
            {
            }
            column(VU2; VU[2])
            {
            }
            column(VU3; VU[3])
            {
            }
            column(VU4; VU[4])
            {
            }
            column(VU5; VU[5])
            {
            }
            column(VU6; VU[6])
            {
            }
            column(VU7; VU[7])
            {
            }
            column(VU8; VU[8])
            {
            }
            column(VU9; VU[9])
            {
            }
            column(VU10; VU[10])
            {
            }
            column(VP1; VP[1])
            {
            }
            column(VP2; VP[2])
            {
            }
            column(VP3; VP[3])
            {
            }
            column(VP4; VP[4])
            {
            }
            column(VP5; VP[5])
            {
            }
            column(VP6; VP[6])
            {
            }
            column(VP7; VP[7])
            {
            }
            column(VP8; VP[8])
            {
            }
            column(VP9; VP[9])
            {
            }
            column(VP10; VP[10])
            {
            }

            trigger OnAfterGetRecord()
            begin

                FOR i := 1 TO 10 DO BEGIN
                    VU[i] := 0;
                    VP[i] := 0;
                END;

                FOR i := 1 TO 10 DO BEGIN
                    PLine.RESET;
                    PLine.SETFILTER(PLine."No.", GETFILTER("No."));
                    PLine.SETRANGE(PLine."Buy-from Vendor No.", VDesc[i]);
                    PLine.SETRANGE(PLine."Description 2", "Description 2");
                    IF PLine.FIND('-') THEN BEGIN
                        VU[i] := PLine."Direct Unit Cost";
                        VP[i] := PLine."Line Amount";
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin

                LastFieldNo := FIELDNO("Description 2");

                LastFieldNo := FIELDNO("No.");

                PuchH.RESET;
                PuchH.SETFILTER(PuchH."No.", GETFILTER("No."));
                PuchH.SETRANGE(PuchH."Document Type", PuchH."Document Type"::Quote);
                IF PuchH.FIND('-') THEN BEGIN
                    REPEAT
                        IF i < 11 THEN BEGIN
                            i := i + 1;
                            VDesc[i] := PuchH."Buy-from Vendor No.";
                            IF Vend.GET(PuchH."Buy-from Vendor No.") THEN
                                VDesc1[i] := Vend.Name;
                        END;
                    UNTIL PuchH.NEXT = 0;
                END;

                PLine.RESET;
                PLine.SETFILTER(PLine."No.", GETFILTER("No."));
                IF PLine.FIND('-') THEN BEGIN
                    REPEAT
                        PLine."Description 2" := COPYSTR(PLine."Description 2", 1, 30);
                        PLine.MODIFY;
                    UNTIL PLine.NEXT = 0;
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Vend: Record 23;
        VDesc: array[20] of Text[200];
        i: Integer;

        VDesc1: array[20] of Text[200];
        VU: array[20] of Decimal;
        VP: array[20] of Decimal;
        PLine: Record 39;
        PuchH: Record 38;
}

