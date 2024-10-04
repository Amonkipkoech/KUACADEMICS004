/* page 66601 "ACA Lect. Marks Capture Lines"
{
    Caption = 'Budget Matrix';
    DataCaptionExpression = BudgetName;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Dimension Code Buffer";

    layout
    {
        area(content)
        {
            repeater(group)
            {
                IndentationColumn = NameIndent;
                IndentationControls = Name;
                field(Code; Rec.Code)
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    ToolTip = 'Specifies the code of the record.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookUpCode(LineDimOption, LineDimCode, Rec.Code);
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    ToolTip = 'Specifies the name of the record.';
                }
                field(TotalBudgetedAmount; Rec.Amount)
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    Caption = 'Budgeted Amount';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = Emphasize;
                    ToolTip = 'Specifies the G/L account''s total budget.';

                    trigger OnDrillDown()
                    begin
                        SetCommonFilters(GLAccBudgetBuf);
                        SetDimFilters(GLAccBudgetBuf, 0);
                        BudgetDrillDown;
                    end;
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[1];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(1);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(1);
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[2];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(2);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(2);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[3];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(3);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(3);
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[4];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(4);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(4);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[5];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(5);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(5);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[6];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(6);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(6);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[7];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(7);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(7);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[8];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(8);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(8);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[9];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(9);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(9);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[10];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(10);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(10);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[11];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(11);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(11);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = Suite;
                    AutoFormatExpression = FormatStr;
                    AutoFormatType = 10;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_CaptionSet[12];
                    Style = Strong;
                    StyleExpr = Emphasize;

                    trigger OnDrillDown()
                    begin
                        MATRIX_OnDrillDown(12);
                    end;

                    trigger OnValidate()
                    begin
                        UpdateAmount(12);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Balance")
            {
                Caption = '&Balance';
                Image = Balance;
                action("G/L Account Balance/Bud&get")
                {
                    ApplicationArea = Suite;
                    Caption = 'G/L Account Balance/Bud&get';
                    Image = Period;
                    ToolTip = 'Open a summary of the debit and credit balances for the current budget.';

                    trigger OnAction()
                    begin
                        GLAccountBalanceBudget;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        MATRIX_CurrentColumnOrdinal: Integer;
    begin
        NameIndent := 0;
        FOR MATRIX_CurrentColumnOrdinal := 1 TO MATRIX_CurrentNoOfMatrixColumn DO
            MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);
        Rec.Amount := MatrixMgt.RoundValue(CalcAmount(FALSE), RoundingFactor);
        FormatLine;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        EXIT(FindRec(LineDimOption, Rec, Which));
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        EXIT(NextRec(LineDimOption, Rec, Steps));
    end;

    trigger OnOpenPage()
    begin
        IF GLAccBudgetBuf.GETFILTER("Global Dimension 1 Filter") <> '' THEN
            GlobalDim1Filter := GLAccBudgetBuf.GETFILTER("Global Dimension 1 Filter");
        IF GLAccBudgetBuf.GETFILTER("Global Dimension 2 Filter") <> '' THEN
            GlobalDim2Filter := GLAccBudgetBuf.GETFILTER("Global Dimension 2 Filter");

        GLSetup.GET;
    end;

    var
        Text001: Label 'Period';
        Text002: Label 'You may only edit column 1 to %1.';
        GLSetup: Record 98;
        GLAccBudgetBuf: Record 374;
        GLBudgetName: Record 95;
        MatrixRecords: array[12] of Record 367;
        MATRIX_MatrixRecord: Record 367;
        MatrixMgt: Codeunit 9200;
        BudgetName: Code[10];
        LineDimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4";
        ColumnDimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4";
        LineDimCode: Text[30];
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        RoundingFactor: Option "None","1","1000","1000000";
        DateFilter: Text[30];
        InternalDateFilter: Text[30];
        BusUnitFilter: Code[250];
        GLAccFilter: Code[250];
        GlobalDim1Filter: Code[250];
        GlobalDim2Filter: Code[250];
        BudgetDim1Filter: Code[250];
        BudgetDim2Filter: Code[250];
        BudgetDim3Filter: Code[250];
        BudgetDim4Filter: Code[250];
        PeriodInitialized: Boolean;
        MATRIX_CurrentNoOfMatrixColumn: Integer;
        MATRIX_CellData: array[12] of Decimal;
        MATRIX_CaptionSet: array[12] of Text[80];
        RoundingFactorFormatString: Text;
        [InDataSet]
        Emphasize: Boolean;
        [InDataSet]
        NameIndent: Integer;

    local procedure DimCodeToOption(DimCode: Text[30]): Integer
    var
        BusUnit: Record 220;
        GLAcc: Record 15;
    begin
        CASE DimCode OF
            '':
                EXIT(-1);
            GLAcc.TABLECAPTION:
                EXIT(0);
            Text001:
                EXIT(1);
            BusUnit.TABLECAPTION:
                EXIT(2);
            GLSetup."Global Dimension 1 Code":
                EXIT(3);
            GLSetup."Global Dimension 2 Code":
                EXIT(4);
            GLBudgetName."Budget Dimension 1 Code":
                EXIT(5);
            GLBudgetName."Budget Dimension 2 Code":
                EXIT(6);
            GLBudgetName."Budget Dimension 3 Code":
                EXIT(7);
            GLBudgetName."Budget Dimension 4 Code":
                EXIT(8);
            ELSE
                EXIT(-1);
        END;
    end;

    local procedure FindRec(DimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4"; var DimCodeBuf: Record 367; Which: Text[250]): Boolean
    var
        GLAcc: Record 15;
        BusUnit: Record 220;
        Period: Record 2000000007;
        DimVal: Record 349;
        PeriodFormMgt: Codeunit 359;
        Found: Boolean;
    begin
        CASE DimOption OF
            DimOption::"G/L Account":
                BEGIN
                    GLAcc."No." := DimCodeBuf.Code;
                    IF GLAccFilter <> '' THEN
                        GLAcc.SETFILTER("No.", GLAccFilter);
                    Found := GLAcc.FIND(Which);
                    IF Found THEN
                        CopyGLAccToBuf(GLAcc, DimCodeBuf);
                END;
            DimOption::Period:
                BEGIN
                    IF NOT PeriodInitialized THEN
                        DateFilter := '';
                    PeriodInitialized := TRUE;
                    Period."Period Start" := DimCodeBuf."Period Start";
                    IF DateFilter <> '' THEN
                        Period.SETFILTER("Period Start", DateFilter)
                    ELSE
                        IF NOT PeriodInitialized AND (InternalDateFilter <> '') THEN
                            Period.SETFILTER("Period Start", InternalDateFilter);
                    Found := PeriodFormMgt.FindDate(Which, Period, PeriodType);
                    IF Found THEN
                        CopyPeriodToBuf(Period, DimCodeBuf);
                END;
            DimOption::"Business Unit":
                BEGIN
                    BusUnit.Code := DimCodeBuf.Code;
                    IF BusUnitFilter <> '' THEN
                        BusUnit.SETFILTER(Code, BusUnitFilter);
                    Found := BusUnit.FIND(Which);
                    IF Found THEN
                        CopyBusUnitToBuf(BusUnit, DimCodeBuf);
                END;
            DimOption::"Global Dimension 1":
                BEGIN
                    IF GlobalDim1Filter <> '' THEN
                        DimVal.SETFILTER(Code, GlobalDim1Filter);
                    DimVal."Dimension Code" := GLSetup."Global Dimension 1 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    Found := DimVal.FIND(Which);
                    IF Found THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Global Dimension 2":
                BEGIN
                    IF GlobalDim2Filter <> '' THEN
                        DimVal.SETFILTER(Code, GlobalDim2Filter);
                    DimVal."Dimension Code" := GLSetup."Global Dimension 2 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    Found := DimVal.FIND(Which);
                    IF Found THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Budget Dimension 1":
                BEGIN
                    IF BudgetDim1Filter <> '' THEN
                        DimVal.SETFILTER(Code, BudgetDim1Filter);
                    DimVal."Dimension Code" := GLBudgetName."Budget Dimension 1 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    Found := DimVal.FIND(Which);
                    IF Found THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Budget Dimension 2":
                BEGIN
                    IF BudgetDim2Filter <> '' THEN
                        DimVal.SETFILTER(Code, BudgetDim2Filter);
                    DimVal."Dimension Code" := GLBudgetName."Budget Dimension 2 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    Found := DimVal.FIND(Which);
                    IF Found THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Budget Dimension 3":
                BEGIN
                    IF BudgetDim3Filter <> '' THEN
                        DimVal.SETFILTER(Code, BudgetDim3Filter);
                    DimVal."Dimension Code" := GLBudgetName."Budget Dimension 3 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    Found := DimVal.FIND(Which);
                    IF Found THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Budget Dimension 4":
                BEGIN
                    IF BudgetDim4Filter <> '' THEN
                        DimVal.SETFILTER(Code, BudgetDim4Filter);
                    DimVal."Dimension Code" := GLBudgetName."Budget Dimension 4 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    Found := DimVal.FIND(Which);
                    IF Found THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
        END;
        EXIT(Found);
    end;

    local procedure NextRec(DimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4"; var DimCodeBuf: Record 367; Steps: Integer): Integer
    var


        ResultSteps: Integer;

        GLAcc: Record 15;
        BusUnit: Record 220;
        Period: Record 2000000007;
        DimVal: Record 349;
        PeriodFormMgt: Codeunit 359;

    begin
        CASE DimOption OF
            DimOption::"G/L Account":
                BEGIN
                    GLAcc."No." := DimCodeBuf.Code;
                    IF GLAccFilter <> '' THEN
                        GLAcc.SETFILTER("No.", GLAccFilter);
                    ResultSteps := GLAcc.NEXT(Steps);
                    IF ResultSteps <> 0 THEN
                        CopyGLAccToBuf(GLAcc, DimCodeBuf);
                END;
            DimOption::Period:
                BEGIN
                    IF DateFilter <> '' THEN
                        Period.SETFILTER("Period Start", DateFilter);
                    Period."Period Start" := DimCodeBuf."Period Start";
                    ResultSteps := PeriodFormMgt.NextDate(Steps, Period, PeriodType);
                    IF ResultSteps <> 0 THEN
                        CopyPeriodToBuf(Period, DimCodeBuf);
                END;
            DimOption::"Business Unit":
                BEGIN
                    BusUnit.Code := DimCodeBuf.Code;
                    IF BusUnitFilter <> '' THEN
                        BusUnit.SETFILTER(Code, BusUnitFilter);
                    ResultSteps := BusUnit.NEXT(Steps);
                    IF ResultSteps <> 0 THEN
                        CopyBusUnitToBuf(BusUnit, DimCodeBuf);
                END;
            DimOption::"Global Dimension 1":
                BEGIN
                    IF GlobalDim1Filter <> '' THEN
                        DimVal.SETFILTER(Code, GlobalDim1Filter);
                    DimVal."Dimension Code" := GLSetup."Global Dimension 1 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    ResultSteps := DimVal.NEXT(Steps);
                    IF ResultSteps <> 0 THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Global Dimension 2":
                BEGIN
                    IF GlobalDim2Filter <> '' THEN
                        DimVal.SETFILTER(Code, GlobalDim2Filter);
                    DimVal."Dimension Code" := GLSetup."Global Dimension 2 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    ResultSteps := DimVal.NEXT(Steps);
                    IF ResultSteps <> 0 THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Budget Dimension 1":
                BEGIN
                    IF BudgetDim1Filter <> '' THEN
                        DimVal.SETFILTER(Code, BudgetDim1Filter);
                    DimVal."Dimension Code" := GLBudgetName."Budget Dimension 1 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    ResultSteps := DimVal.NEXT(Steps);
                    IF ResultSteps <> 0 THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Budget Dimension 2":
                BEGIN
                    IF BudgetDim2Filter <> '' THEN
                        DimVal.SETFILTER(Code, BudgetDim2Filter);
                    DimVal."Dimension Code" := GLBudgetName."Budget Dimension 2 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    ResultSteps := DimVal.NEXT(Steps);
                    IF ResultSteps <> 0 THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Budget Dimension 3":
                BEGIN
                    IF BudgetDim3Filter <> '' THEN
                        DimVal.SETFILTER(Code, BudgetDim3Filter);
                    DimVal."Dimension Code" := GLBudgetName."Budget Dimension 3 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    ResultSteps := DimVal.NEXT(Steps);
                    IF ResultSteps <> 0 THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
            DimOption::"Budget Dimension 4":
                BEGIN
                    IF BudgetDim4Filter <> '' THEN
                        DimVal.SETFILTER(Code, BudgetDim4Filter);
                    DimVal."Dimension Code" := GLBudgetName."Budget Dimension 4 Code";
                    DimVal.SETRANGE("Dimension Code", DimVal."Dimension Code");
                    DimVal.Code := DimCodeBuf.Code;
                    ResultSteps := DimVal.NEXT(Steps);
                    IF ResultSteps <> 0 THEN
                        CopyDimValToBuf(DimVal, DimCodeBuf);
                END;
        END;
        EXIT(ResultSteps);
    end;

    local procedure CopyGLAccToBuf(var TheGLAcc: Record 15; var TheDimCodeBuf: Record 367)
    begin
        Rec.INIT;
        Rec.Code := TheGLAcc."No.";
        Rec.Name := TheGLAcc.Name;
        Rec.Totaling := TheGLAcc.Totaling;
        Rec.Indentation := TheGLAcc.Indentation;
        Rec."Show in Bold" := TheGLAcc."Account Type" <> TheGLAcc."Account Type"::Posting;
    end;

    local procedure CopyPeriodToBuf(var ThePeriod: Record 2000000007; var TheDimCodeBuf: Record 367)
    var
        Period2: Record 2000000007;
    begin
        Rec.INIT;
        Rec.Code := FORMAT(ThePeriod."Period Start");
        Rec."Period Start" := ThePeriod."Period Start";
        Rec."Period End" := ThePeriod."Period End";
        IF DateFilter <> '' THEN BEGIN
            Period2.SETFILTER("Period End", DateFilter);
            IF Period2.GETRANGEMAX("Period End") < Rec."Period End" THEN
                Rec."Period End" := Period2.GETRANGEMAX("Period End");
        END;
        Rec.Name := ThePeriod."Period Name";
    end;

    local procedure CopyBusUnitToBuf(var TheBusUnit: Record 220; var TheDimCodeBuf: Record 367)
    begin
        Rec.INIT;
        Rec.Code := TheBusUnit.Code;
        IF TheBusUnit.Name <> '' THEN
            Rec.Name := TheBusUnit.Name
        ELSE
            Rec.Name := TheBusUnit."Company Name";
    end;

    local procedure CopyDimValToBuf(var TheDimVal: Record 349; var TheDimCodeBuf: Record 367)
    begin
        Rec.INIT;
        Rec.Code := TheDimVal.Code;
        Rec.Name := TheDimVal.Name;
        Rec.Totaling := TheDimVal.Totaling;
        Rec.Indentation := TheDimVal.Indentation;
        Rec."Show in Bold" :=
          TheDimVal."Dimension Value Type" <> TheDimVal."Dimension Value Type"::Standard;
    end;

    local procedure LookUpCode(DimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4"; DimCode: Text[30]; "Code": Text[30])
    var
        GLAcc: Record 15;
        BusUnit: Record 220;
        DimVal: Record 349;
    begin
        CASE DimOption OF
            DimOption::"G/L Account":
                BEGIN
                    GLAcc.GET(Code);
                    PAGE.RUNMODAL(PAGE::"G/L Account List", GLAcc);
                END;
            DimOption::Period:
                ;
            DimOption::"Business Unit":
                BEGIN
                    BusUnit.GET(Code);
                    PAGE.RUNMODAL(PAGE::"Business Unit List", BusUnit);
                END;
            DimOption::"Global Dimension 1", DimOption::"Global Dimension 2",
            DimOption::"Budget Dimension 1", DimOption::"Budget Dimension 2",
            DimOption::"Budget Dimension 3", DimOption::"Budget Dimension 4":
                BEGIN
                    DimVal.SETRANGE("Dimension Code", DimCode);
                    DimVal.GET(DimCode, Code);

                    PAGE.RUNMODAL(PAGE::"Dimension Value List", DimVal);
                END;
        END;
    end;

    local procedure SetCommonFilters(var TheGLAccBudgetBuf: Record 374)
    begin
        Rec.RESET;
        Rec.SETRANGE("Budget Filter", GLBudgetName.Name);
        IF BusUnitFilter <> '' THEN
            Rec.SETFILTER("Business Unit Filter", BusUnitFilter);
        IF GLAccFilter <> '' THEN
            Rec.SETFILTER("G/L Account Filter", GLAccFilter);
        IF DateFilter <> '' THEN
            Rec.SETFILTER("Date Filter", DateFilter);
        IF GlobalDim1Filter <> '' THEN
            Rec.SETFILTER("Global Dimension 1 Filter", GlobalDim1Filter);
        IF GlobalDim2Filter <> '' THEN
            Rec.SETFILTER("Global Dimension 2 Filter", GlobalDim2Filter);
        IF BudgetDim1Filter <> '' THEN
            Rec.SETFILTER("Budget Dimension 1 Filter", BudgetDim1Filter);
        IF BudgetDim2Filter <> '' THEN
            Rec.SETFILTER("Budget Dimension 2 Filter", BudgetDim2Filter);
        IF BudgetDim3Filter <> '' THEN
            Rec.SETFILTER("Budget Dimension 3 Filter", BudgetDim3Filter);
        IF BudgetDim4Filter <> '' THEN
            Rec.SETFILTER("Budget Dimension 4 Filter", BudgetDim4Filter);
    end;

    local procedure SetDimFilters(var TheGLAccBudgetBuf: Record 374; LineOrColumn: Option Line,Column)
    var
        DimCodeBuf: Record 367;
        DimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4";
    begin
        IF LineOrColumn = LineOrColumn::Line THEN BEGIN
            DimCodeBuf := Rec;
            DimOption := LineDimOption;
        END ELSE BEGIN
            DimCodeBuf := MATRIX_MatrixRecord;
            DimOption := ColumnDimOption;
        END;

        CASE DimOption OF
            DimOption::"G/L Account":
                IF DimCodeBuf.Totaling <> '' THEN
                    GLAccBudgetBuf.SETFILTER("G/L Account Filter", DimCodeBuf.Totaling)
                ELSE
                    GLAccBudgetBuf.SETRANGE("G/L Account Filter", DimCodeBuf.Code);
            DimOption::Period:
                Rec.SETRANGE("Date Filter", DimCodeBuf."Period Start", DimCodeBuf."Period End");
            DimOption::"Business Unit":
                Rec.SETRANGE("Business Unit Filter", DimCodeBuf.Code);
            DimOption::"Global Dimension 1":
                IF DimCodeBuf.Totaling <> '' THEN
                    Rec.SETFILTER("Global Dimension 1 Filter", DimCodeBuf.Totaling)
                ELSE
                    Rec.SETRANGE("Global Dimension 1 Filter", DimCodeBuf.Code);
            DimOption::"Global Dimension 2":
                IF DimCodeBuf.Totaling <> '' THEN
                    Rec.SETFILTER("Global Dimension 2 Filter", DimCodeBuf.Totaling)
                ELSE
                    Rec.SETRANGE("Global Dimension 2 Filter", DimCodeBuf.Code);
            DimOption::"Budget Dimension 1":
                IF DimCodeBuf.Totaling <> '' THEN
                    Rec.SETFILTER("Budget Dimension 1 Filter", DimCodeBuf.Totaling)
                ELSE
                    Rec.SETRANGE("Budget Dimension 1 Filter", DimCodeBuf.Code);
            DimOption::"Budget Dimension 2":
                IF DimCodeBuf.Totaling <> '' THEN
                    Rec.SETFILTER("Budget Dimension 2 Filter", DimCodeBuf.Totaling)
                ELSE
                    Rec.SETRANGE("Budget Dimension 2 Filter", DimCodeBuf.Code);
            DimOption::"Budget Dimension 3":
                IF DimCodeBuf.Totaling <> '' THEN
                    Rec.SETFILTER("Budget Dimension 3 Filter", DimCodeBuf.Totaling)
                ELSE
                    Rec.SETRANGE("Budget Dimension 3 Filter", DimCodeBuf.Code);
            DimOption::"Budget Dimension 4":
                IF DimCodeBuf.Totaling <> '' THEN
                    Rec.SETFILTER("Budget Dimension 4 Filter", DimCodeBuf.Totaling)
                ELSE
                    Rec.SETRANGE("Budget Dimension 4 Filter", DimCodeBuf.Code);
        END;
    end;

    local procedure BudgetDrillDown()
    var
        GLBudgetEntry: Record 96;
    begin
        GLBudgetEntry.SETRANGE("Budget Name", GLBudgetName.Name);
        IF GLAccBudgetBuf.GETFILTER("G/L Account Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("G/L Account Filter", GLBudgetEntry."G/L Account No.");
        IF GLAccBudgetBuf.GETFILTER("Business Unit Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("Business Unit Filter", GLBudgetEntry."Business Unit Code");
        IF GLAccBudgetBuf.GETFILTER("Global Dimension 1 Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("Global Dimension 1 Filter", GLBudgetEntry."Global Dimension 1 Code");
        IF GLAccBudgetBuf.GETFILTER("Global Dimension 2 Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("Global Dimension 2 Filter", GLBudgetEntry."Global Dimension 2 Code");
        IF GLAccBudgetBuf.GETFILTER("Budget Dimension 1 Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("Budget Dimension 1 Filter", GLBudgetEntry."Budget Dimension 1 Code");
        IF GLAccBudgetBuf.GETFILTER("Budget Dimension 2 Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("Budget Dimension 2 Filter", GLBudgetEntry."Budget Dimension 2 Code");
        IF GLAccBudgetBuf.GETFILTER("Budget Dimension 3 Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("Budget Dimension 3 Filter", GLBudgetEntry."Budget Dimension 3 Code");
        IF GLAccBudgetBuf.GETFILTER("Budget Dimension 4 Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("Budget Dimension 4 Filter", GLBudgetEntry."Budget Dimension 4 Code");
        IF GLAccBudgetBuf.GETFILTER("Date Filter") <> '' THEN
            GLAccBudgetBuf.COPYFILTER("Date Filter", GLBudgetEntry.Date)
        ELSE
            GLBudgetEntry.SETRANGE(Date, 0D, DMY2DATE(31, 12, 9999));
        IF (Rec.GETFILTER("Global Dimension 1 Code") <> '') OR (Rec.GETFILTER("Global Dimension 2 Code") <> '') OR
   (Rec.GETFILTER("Business Unit Code") <> '')
THEN
            Rec.SETCURRENTKEY("Budget Name", "G/L Account No.", "Business Unit Code", "Global Dimension 1 Code")
        ELSE
            Rec.SETCURRENTKEY("Budget Name", "G/L Account No.", Date);
        PAGE.RUN(0, GLBudgetEntry);
    end;

    local procedure CalcAmount(SetColumnFilter: Boolean): Decimal
    begin
        SetCommonFilters(GLAccBudgetBuf);
        SetDimFilters(GLAccBudgetBuf, 0);
        IF SetColumnFilter THEN
            SetDimFilters(GLAccBudgetBuf, 1);
        GLAccBudgetBuf.CALCFIELDS("Budgeted Amount");
        EXIT(GLAccBudgetBuf."Budgeted Amount");
    end;

    local procedure FromRoundedValue(OrgAmount: Decimal): Decimal
    var
        NewAmount: Decimal;
    begin
        NewAmount := OrgAmount;
        CASE RoundingFactor OF
            RoundingFactor::"1000":
                NewAmount := OrgAmount * 1000;
            RoundingFactor::"1000000":
                NewAmount := OrgAmount * 1000000;
        END;
        EXIT(NewAmount);
    end;

    procedure Load(MatrixColumns1: array[32] of Text[80]; var MatrixRecords1: array[12] of Record 367; CurrentNoOfMatrixColumns: Integer; _LineDimCode: Text[30]; _LineDimOption: Integer; _ColumnDimOption: Integer; _GlobalDim1Filter: Code[250]; _GlobalDim2Filter: Code[250]; _BudgetDim1Filter: Code[250]; _BudgetDim2Filter: Code[250]; _BudgetDim3Filter: Code[250]; _BudgetDim4Filter: Code[250]; var _GLBudgetName: Record "95"; _DateFilter: Text[30]; _GLAccFilter: Code[250]; _RoundingFactor: Integer; _PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period")
    var
        i: Integer;
    begin
        FOR i := 1 TO 12 DO
            MATRIX_CellData[i] := 0;

        FOR i := 1 TO 12 DO BEGIN
            IF MatrixColumns1[i] = '' THEN
                MATRIX_CaptionSet[i] := ' '
            ELSE
                MATRIX_CaptionSet[i] := MatrixColumns1[i];
            MatrixRecords[i] := MatrixRecords1[i];
        END;
        IF CurrentNoOfMatrixColumns > ARRAYLEN(MATRIX_CellData) THEN
            MATRIX_CurrentNoOfMatrixColumn := ARRAYLEN(MATRIX_CellData)
        ELSE
            MATRIX_CurrentNoOfMatrixColumn := CurrentNoOfMatrixColumns;
        LineDimCode := _LineDimCode;
        LineDimOption := _LineDimOption;
        ColumnDimOption := _ColumnDimOption;
        GlobalDim1Filter := _GlobalDim1Filter;
        GlobalDim2Filter := _GlobalDim2Filter;
        BudgetDim1Filter := _BudgetDim1Filter;
        BudgetDim2Filter := _BudgetDim2Filter;
        BudgetDim3Filter := _BudgetDim3Filter;
        BudgetDim4Filter := _BudgetDim4Filter;
        GLBudgetName := _GLBudgetName;
        DateFilter := _DateFilter;
        GLAccFilter := _GLAccFilter;
        RoundingFactor := _RoundingFactor;
        PeriodType := _PeriodType;
        RoundingFactorFormatString := MatrixMgt.GetFormatString(RoundingFactor, FALSE);
    end;

    local procedure MATRIX_OnDrillDown(MATRIX_ColumnOrdinal: Integer)
    begin
        MATRIX_MatrixRecord := MatrixRecords[MATRIX_ColumnOrdinal];
        SetCommonFilters(GLAccBudgetBuf);
        SetDimFilters(GLAccBudgetBuf, 0);
        SetDimFilters(GLAccBudgetBuf, 1);
        BudgetDrillDown;
    end;

    local procedure MATRIX_OnAfterGetRecord(MATRIX_ColumnOrdinal: Integer)
    begin
        MATRIX_MatrixRecord := MatrixRecords[MATRIX_ColumnOrdinal];
        MATRIX_CellData[MATRIX_ColumnOrdinal] := MatrixMgt.RoundValue(CalcAmount(TRUE), RoundingFactor);
    end;

    local procedure UpdateAmount(MATRIX_ColumnOrdinal: Integer)
    var
        NewAmount: Decimal;
    begin
        IF MATRIX_ColumnOrdinal > MATRIX_CurrentNoOfMatrixColumn THEN
            ERROR(Text002, MATRIX_CurrentNoOfMatrixColumn);
        MATRIX_MatrixRecord := MatrixRecords[MATRIX_ColumnOrdinal];
        NewAmount := FromRoundedValue(MATRIX_CellData[MATRIX_ColumnOrdinal]);
        IF CalcAmount(TRUE) = 0 THEN; // To set filters correctly
        GLAccBudgetBuf.CALCFIELDS("Budgeted Amount");
        GLAccBudgetBuf.VALIDATE("Budgeted Amount", NewAmount);
        Rec.Amount := MatrixMgt.RoundValue(CalcAmount(FALSE), RoundingFactor);
        CurrPage.UPDATE;
    end;

    local procedure GLAccountBalanceBudget()
    var
        GLAcc: Record 15;
    begin
        IF DimCodeToOption(LineDimCode) = 0 THEN
            GLAcc.GET(Rec.Code)
        ELSE BEGIN
            IF GLAccFilter <> '' THEN
                GLAcc.SETFILTER("No.", GLAccFilter);
            GLAcc.FINDFIRST;
            GLAcc.RESET;
        END;
        Rec.SETRANGE("Budget Filter", GLBudgetName.Name);
        IF BusUnitFilter <> '' THEN
            Rec.SETFILTER("Business Unit Filter", BusUnitFilter);
        IF GLAccFilter <> '' THEN
            Rec.SETFILTER("No.", GLAccFilter);
        IF GlobalDim1Filter <> '' THEN
            Rec.SETFILTER("Global Dimension 1 Filter", GlobalDim1Filter);
        IF GlobalDim2Filter <> '' THEN
            Rec.SETFILTER("Global Dimension 2 Filter", GlobalDim2Filter);
        PAGE.RUN(PAGE::"G/L Account Balance/Budget", GLAcc);
    end;

    local procedure FormatLine()
    begin
        Emphasize := Rec."Show in Bold";
        NameIndent := Rec.Indentation;
    end;

    local procedure FormatStr(): Text
    begin
        EXIT(RoundingFactorFormatString);
    end;
}
 */
