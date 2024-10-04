/* page 66600 "ACA-Lecturer Marks Capture"
{
    Caption = 'Budget';
    DataCaptionExpression = BudgetName;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = ListPlus;
    SaveValues = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(BudgetName; BudgetName)
                {
                    ApplicationArea = Suite;
                    Caption = 'Budget Name';
                    TableRelation = "G/L Budget Name";
                    ToolTip = 'Specifies the name of the budget.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        GLBudgetNames: Page 121;
                    begin
                        GLBudgetNames.LOOKUPMODE := TRUE;
                        GLBudgetNames.SETRECORD(GLBudgetName);
                        IF GLBudgetNames.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            GLBudgetNames.GETRECORD(GLBudgetName);
                            BudgetName := GLBudgetName.Name;
                            Text := GLBudgetName.Name;
                            ValidateBudgetName;
                            ValidateLineDimCode;
                            ValidateColumnDimCode;
                            UpdateMatrixSubform;
                            EXIT(TRUE);
                        END;
                        ValidateBudgetName;
                        ValidateLineDimCode;
                        ValidateColumnDimCode;
                        CurrPage.UPDATE;
                        EXIT(FALSE);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateBudgetName;
                        ValidateLineDimCode;
                        ValidateColumnDimCode;

                        UpdateMatrixSubform;
                    end;
                }
                field(LineDimCode; LineDimCode)
                {
                    ApplicationArea = Suite;
                    Caption = 'Show as Lines';
                    ToolTip = 'Specifies which values you want to show as lines in the window. This allows you to see the same matrix window from various perspectives, especially when you use both the Show as Lines field and the Show as Columns field.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        NewCode: Text[30];
                    begin
                        NewCode := GetDimSelection(LineDimCode);
                        IF NewCode = LineDimCode THEN
                            EXIT(FALSE);

                        Text := NewCode;
                        LineDimCode := NewCode;
                        ValidateLineDimCode;
                        LineDimCodeOnAfterValidate;
                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    var
                        MATRIX_SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
                    begin
                        IF (UPPERCASE(LineDimCode) = UPPERCASE(ColumnDimCode)) AND (LineDimCode <> '') THEN BEGIN
                            ColumnDimCode := '';
                            ValidateColumnDimCode;
                        END;
                        ValidateLineDimCode;
                        MATRIX_GenerateColumnCaptions(MATRIX_SetWanted::Initial);
                        LineDimCodeOnAfterValidate;
                    end;
                }
                field(ColumnDimCode; ColumnDimCode)
                {
                    ApplicationArea = Suite;
                    Caption = 'Show as Columns';
                    ToolTip = 'Specifies which values you want to show as columns in the window. This allows you to see the same matrix window from various perspectives, especially when you use both the Show as Lines field and the Show as Columns field.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        NewCode: Text[30];
                        MATRIX_Step: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
                    begin
                        NewCode := GetDimSelection(ColumnDimCode);
                        IF NewCode = ColumnDimCode THEN
                            EXIT(FALSE);

                        Text := NewCode;
                        ColumnDimCode := NewCode;
                        ValidateColumnDimCode;
                        MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);
                        ColumnDimCodeOnAfterValidate;
                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    var
                        MATRIX_Step: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
                    begin
                        IF (UPPERCASE(LineDimCode) = UPPERCASE(ColumnDimCode)) AND (LineDimCode <> '') THEN BEGIN
                            LineDimCode := '';
                            ValidateLineDimCode;
                        END;
                        ValidateColumnDimCode;
                        MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);
                        ColumnDimCodeOnAfterValidate;
                    end;
                }
                field(PeriodType; PeriodType)
                {
                    ApplicationArea = Suite;
                    Caption = 'View by';
                    Enabled = PeriodTypeEnable;
                    OptionCaption = 'Day,Week,Month,Quarter,Year,Accounting Period';
                    ToolTip = 'Specifies by which period amounts are displayed.';

                    trigger OnValidate()
                    begin
                        FindPeriod('');
                        PeriodTypeOnAfterValidate;
                    end;
                }
                field(RoundingFactor; RoundingFactor)
                {
                    ApplicationArea = Suite;
                    Caption = 'Rounding Factor';
                    OptionCaption = 'None,1,1000,1000000';
                    ToolTip = 'Specifies the factor that is used to round the amounts.';

                    trigger OnValidate()
                    begin
                        UpdateMatrixSubform;
                    end;
                }
                field(ShowColumnName; ShowColumnName)
                {
                    ApplicationArea = Suite;
                    Caption = 'Show Column Name';
                    ToolTip = 'Specifies that the names of columns are shown in the matrix window.';

                    trigger OnValidate()
                    begin
                        ShowColumnNameOnPush;
                    end;
                }
            }
            part(MatrixForm; 66601)
            {
                ApplicationArea = Suite;
            }
            group(Filters)
            {
                Caption = 'Filters';
                field(DateFilter; DateFilter)
                {
                    ApplicationArea = Suite;
                    Caption = 'Date Filter';
                    ToolTip = 'Specifies the dates that will be used to filter the amounts in the window.';

                    trigger OnValidate()
                    var
                        ApplicationManagement: Codeunit 1;
                    begin
                        IF ApplicationManagement.MakeDateFilter(DateFilter) = 0 THEN;
                        GLAccBudgetBuf.SETFILTER("Date Filter", DateFilter);
                        DateFilter := GLAccBudgetBuf.GETFILTER("Date Filter");
                        InternalDateFilter := DateFilter;
                        DateFilterOnAfterValidate;
                    end;
                }
                field(GLAccFilter; GLAccFilter)
                {
                    ApplicationArea = Suite;
                    Caption = 'G/L Account Filter';
                    ToolTip = 'Specifies the G/L accounts for which you will see information in the window.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        GLAccList: Page 18;
                    begin
                        GLAccList.LOOKUPMODE(TRUE);
                        IF NOT (GLAccList.RUNMODAL = ACTION::LookupOK) THEN
                            EXIT(FALSE);

                        Text := GLAccList.GetSelectionFilter;
                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        GLAccFilterOnAfterValidate;
                    end;
                }
                field(GlobalDim1Filter; GlobalDim1Filter)
                {
                    ApplicationArea = Suite;
                    CaptionClass = '1,3,1';
                    Caption = 'Global Dimension 1 Filter';
                    Enabled = GlobalDim1FilterEnable;
                    ToolTip = 'Specifies a filter by a global dimension. Global dimensions are the dimensions that you analyze most frequently.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EXIT(LookUpDimFilter(GLSetup."Global Dimension 1 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        GlobalDim1FilterOnAfterValidat;
                    end;
                }
                field(GlobalDim2Filter; GlobalDim2Filter)
                {
                    ApplicationArea = Suite;
                    CaptionClass = '1,3,2';
                    Caption = 'Global Dimension 2 Filter';
                    Enabled = GlobalDim2FilterEnable;
                    ToolTip = 'Specifies a filter by a global dimension. Global dimensions are the dimensions that you analyze most frequently.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EXIT(LookUpDimFilter(GLSetup."Global Dimension 2 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        GlobalDim2FilterOnAfterValidat;
                    end;
                }
                field(BudgetDim1Filter; BudgetDim1Filter)
                {
                    ApplicationArea = Suite;
                    CaptionClass = GetCaptionClass(1);
                    Caption = 'Budget Dimension 1 Filter';
                    Enabled = BudgetDim1FilterEnable;
                    ToolTip = 'Specifies a filter by a budget dimension. You can specify four additional dimensions on each budget that you create.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EXIT(LookUpDimFilter(GLBudgetName."Budget Dimension 1 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        BudgetDim1FilterOnAfterValidat;
                    end;
                }
                field(BudgetDim2Filter; BudgetDim2Filter)
                {
                    ApplicationArea = Suite;
                    CaptionClass = GetCaptionClass(2);
                    Caption = 'Budget Dimension 2 Filter';
                    Enabled = BudgetDim2FilterEnable;
                    ToolTip = 'Specifies a filter by a budget dimension. You can specify four additional dimensions on each budget that you create.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EXIT(LookUpDimFilter(GLBudgetName."Budget Dimension 2 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        BudgetDim2FilterOnAfterValidat;
                    end;
                }
                field(BudgetDim3Filter; BudgetDim3Filter)
                {
                    ApplicationArea = Suite;
                    CaptionClass = GetCaptionClass(3);
                    Caption = 'Budget Dimension 3 Filter';
                    Enabled = BudgetDim3FilterEnable;
                    ToolTip = 'Specifies a filter by a budget dimension. You can specify four additional dimensions on each budget that you create.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EXIT(LookUpDimFilter(GLBudgetName."Budget Dimension 3 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        BudgetDim3FilterOnAfterValidat;
                    end;
                }
                field(BudgetDim4Filter; BudgetDim4Filter)
                {
                    ApplicationArea = Suite;
                    CaptionClass = GetCaptionClass(4);
                    Caption = 'Budget Dimension 4 Filter';
                    Enabled = BudgetDim4FilterEnable;
                    ToolTip = 'Specifies a filter by a budget dimension. You can specify four additional dimensions on each budget that you create.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EXIT(LookUpDimFilter(GLBudgetName."Budget Dimension 4 Code", Text));
                    end;

                    trigger OnValidate()
                    begin
                        BudgetDim4FilterOnAfterValidat;
                    end;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Balance")
            {
                Caption = '&Balance';
                Image = Balance;
                action("Page G/L Balance/Budget")
                {
                    ApplicationArea = Suite;
                    Caption = 'G/L Balance/B&udget';
                    Image = ChartOfAccounts;
                    ToolTip = 'Open a summary of the debit and credit balances for the current budget.';

                    trigger OnAction()
                    var
                        GLAccount: Record 15;
                    begin
                        GLAccount.SETFILTER("Budget Filter", BudgetName);
                        PAGE.RUN(PAGE::"G/L Balance/Budget", GLAccount);
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Copy Budget")
                {
                    ApplicationArea = Suite;
                    Caption = 'Copy Budget';
                    Ellipsis = true;
                    Image = CopyBudget;
                    RunObject = Report 96;
                    ToolTip = 'Create a copy of the current budget based on a general ledger entry or a general ledger budget entry.';
                }
                action("Delete Budget")
                {
                    ApplicationArea = Suite;
                    Caption = 'Delete Budget';
                    Image = Delete;
                    ToolTip = 'Delete the current budget.';

                    trigger OnAction()
                    begin
                        DeleteBudget;
                    end;
                }

                action("Export to Excel")
                {
                    ApplicationArea = Suite;
                    Caption = 'Export to Excel';
                    Ellipsis = true;
                    Image = ExportToExcel;
                    ToolTip = 'Export all or part of the budget to Excel for further analysis. If you make changes in Excel, you can import the budget afterwards.';

                    trigger OnAction()
                    var
                        GLBudgetEntry: Record 96;
                        ExportBudgetToExcel: Report 82;
                        PeriodLength: DateFormula;
                    begin
                        GLBudgetEntry.SETFILTER("Budget Name", BudgetName);
                        GLBudgetEntry.SETFILTER("Business Unit Code", BusUnitFilter);
                        GLBudgetEntry.SETFILTER("G/L Account No.", GLAccFilter);
                        GLBudgetEntry.SETFILTER("Global Dimension 1 Code", GlobalDim1Filter);
                        GLBudgetEntry.SETFILTER("Global Dimension 2 Code", GlobalDim2Filter);
                        GLBudgetEntry.SETFILTER("Budget Dimension 1 Code", BudgetDim1Filter);
                        GLBudgetEntry.SETFILTER("Budget Dimension 2 Code", BudgetDim2Filter);
                        GLBudgetEntry.SETFILTER("Budget Dimension 3 Code", BudgetDim3Filter);
                        GLBudgetEntry.SETFILTER("Budget Dimension 4 Code", BudgetDim4Filter);
                        EVALUATE(PeriodLength, '<0D>');
                        ExportBudgetToExcel.SetParameters(0D, 0, PeriodLength, RoundingFactor);
                        ExportBudgetToExcel.SETTABLEVIEW(GLBudgetEntry);
                        ExportBudgetToExcel.RUN;
                    end;
                }
                action("Import from Excel")
                {
                    ApplicationArea = Suite;
                    Caption = 'Import from Excel';
                    Ellipsis = true;
                    Image = ImportExcel;
                    ToolTip = 'Import a budget that you exported to Excel earlier.';

                    trigger OnAction()
                    var
                        ImportBudgetfromExcel: Report 81;
                    begin
                        ImportBudgetfromExcel.SetParameters(BudgetName, 0);
                        ImportBudgetfromExcel.RUNMODAL;
                    end;
                }

                action("Reverse Lines and Columns")
                {
                    ApplicationArea = Suite;
                    Caption = 'Reverse Lines and Columns';
                    Image = Undo;
                    ToolTip = 'Change the display of the matrix by inverting the values in the Show as Lines and Show as Columns fields.';

                    trigger OnAction()
                    var
                        TempDimCode: Text[30];
                    begin
                        TempDimCode := ColumnDimCode;
                        ColumnDimCode := LineDimCode;
                        LineDimCode := TempDimCode;
                        ValidateLineDimCode;
                        ValidateColumnDimCode;

                        MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);
                        UpdateMatrixSubform;
                    end;
                }
            }
            action("Next Period")
            {
                ApplicationArea = Suite;
                Caption = 'Next Period';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Show the information based on the next period. If you set the View by field to Day, the date filter changes to the day before.';

                trigger OnAction()
                begin
                    IF (LineDimOption = LineDimOption::Period) OR (ColumnDimOption = ColumnDimOption::Period) THEN
                        EXIT;
                    FindPeriod('>');
                    CurrPage.UPDATE;
                    UpdateMatrixSubform;
                end;
            }
            action("Previous Period")
            {
                ApplicationArea = Suite;
                Caption = 'Previous Period';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Show the information based on the previous period. If you set the View by field to Day, the date filter changes to the day before.';

                trigger OnAction()
                begin
                    IF (LineDimOption = LineDimOption::Period) OR (ColumnDimOption = ColumnDimOption::Period) THEN
                        EXIT;
                    FindPeriod('<');
                    CurrPage.UPDATE;
                    UpdateMatrixSubform;
                end;
            }
            action("Previous Set")
            {
                ApplicationArea = Suite;
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the previous set of data.';

                trigger OnAction()
                begin
                    MATRIX_GenerateColumnCaptions(MATRIX_Step::Previous);
                    UpdateMatrixSubform;
                end;
            }
            action("Previous Column")
            {
                ApplicationArea = Suite;
                Caption = 'Previous Column';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the previous column.';

                trigger OnAction()
                begin
                    MATRIX_GenerateColumnCaptions(MATRIX_Step::PreviousColumn);
                    UpdateMatrixSubform;
                end;
            }
            action("Next Column")
            {
                ApplicationArea = Suite;
                Caption = 'Next Column';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Show the budget based on the next column.';

                trigger OnAction()
                begin
                    MATRIX_GenerateColumnCaptions(MATRIX_Step::NextColumn);
                    UpdateMatrixSubform;
                end;
            }
            action("Next Set")
            {
                ApplicationArea = Suite;
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the next set of data.';

                trigger OnAction()
                begin
                    MATRIX_GenerateColumnCaptions(MATRIX_Step::Next);
                    UpdateMatrixSubform;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        BudgetDim4FilterEnable := TRUE;
        BudgetDim3FilterEnable := TRUE;
        BudgetDim2FilterEnable := TRUE;
        BudgetDim1FilterEnable := TRUE;
        PeriodTypeEnable := TRUE;
        GlobalDim2FilterEnable := TRUE;
        GlobalDim1FilterEnable := TRUE;
    end;

    trigger OnOpenPage()
    var
        GLAcc: Record 15;
        MATRIX_Step: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
    begin
        IF GLAccBudgetBuf.GETFILTER("Global Dimension 1 Filter") <> '' THEN
            GlobalDim1Filter := GLAccBudgetBuf.GETFILTER("Global Dimension 1 Filter");
        IF GLAccBudgetBuf.GETFILTER("Global Dimension 2 Filter") <> '' THEN
            GlobalDim2Filter := GLAccBudgetBuf.GETFILTER("Global Dimension 2 Filter");

        GLSetup.GET;

        GlobalDim1FilterEnable :=
          (GLSetup."Global Dimension 1 Code" <> '') AND
          (GLAccBudgetBuf.GETFILTER("Global Dimension 1 Filter") = '');
        GlobalDim2FilterEnable :=
          (GLSetup."Global Dimension 2 Code" <> '') AND
          (GLAccBudgetBuf.GETFILTER("Global Dimension 2 Filter") = '');

        ValidateBudgetName;

        IF LineDimCode = '' THEN
            LineDimCode := GLAcc.TABLECAPTION;
        IF ColumnDimCode = '' THEN
            ColumnDimCode := Text001;

        LineDimOption := DimCodeToOption(LineDimCode);
        ColumnDimOption := DimCodeToOption(ColumnDimCode);

        IF (NewBudgetName <> '') AND (NewBudgetName <> BudgetName) THEN BEGIN
            BudgetName := NewBudgetName;
            ValidateBudgetName;
            ValidateLineDimCode;
            ValidateColumnDimCode;
        END;

        FindPeriod('');
        MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);

        UpdateMatrixSubform;
    end;

    var
        GLSetup: Record 98;
        GLAccBudgetBuf: Record 374;
        GLBudgetName: Record 95;
        PrevGLBudgetName: Record 95;
        MATRIX_MatrixRecords: array[32] of Record 367;
        MATRIX_CaptionSet: array[32] of Text[80];
        MATRIX_CaptionRange: Text[80];
        FirstColumn: Text;
        LastColumn: Text;
        MATRIX_PrimKeyFirstCaptionInCu: Text[80];
        MATRIX_CurrentNoOfColumns: Integer;
        Text001: Label 'Period';
        Text003: Label 'Do you want to delete the budget entries shown?';
        Text004: Label 'DEFAULT';
        Text005: Label 'Default budget';
        Text006: Label '%1 is not a valid line definition.';
        Text007: Label '%1 is not a valid column definition.';
        Text008: Label '1,6,,Budget Dimension 1 Filter';
        Text009: Label '1,6,,Budget Dimension 2 Filter';
        Text010: Label '1,6,,Budget Dimension 3 Filter';
        Text011: Label '1,6,,Budget Dimension 4 Filter';
        MATRIX_Step: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        BudgetName: Code[10];
        NewBudgetName: Code[10];
        LineDimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4";
        ColumnDimOption: Option "G/L Account",Period,"Business Unit","Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4";
        LineDimCode: Text[30];
        ColumnDimCode: Text[30];
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        RoundingFactor: Option "None","1","1000","1000000";
        ShowColumnName: Boolean;
        DateFilter: Text[30];
        InternalDateFilter: Text[30];
        BusUnitFilter: Text;
        GLAccFilter: Text;
        GlobalDim1Filter: Text;
        GlobalDim2Filter: Text;
        BudgetDim1Filter: Text;
        BudgetDim2Filter: Text;
        BudgetDim3Filter: Text;
        BudgetDim4Filter: Text;
        [InDataSet]
        GlobalDim1FilterEnable: Boolean;
        [InDataSet]
        GlobalDim2FilterEnable: Boolean;
        [InDataSet]
        PeriodTypeEnable: Boolean;
        [InDataSet]
        BudgetDim1FilterEnable: Boolean;
        [InDataSet]
        BudgetDim2FilterEnable: Boolean;
        [InDataSet]
        BudgetDim3FilterEnable: Boolean;
        [InDataSet]
        BudgetDim4FilterEnable: Boolean;

    local procedure MATRIX_GenerateColumnCaptions(MATRIX_SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MATRIX_PeriodRecords: array[32] of Record 2000000007;
        BusUnit: Record 220;
        GLAccount: Record 15;
        MatrixMgt: Codeunit 9200;
        RecRef: RecordRef;
        FieldRef: FieldRef;
        i: Integer;
    begin
        CLEAR(MATRIX_CaptionSet);
        CLEAR(MATRIX_MatrixRecords);
        FirstColumn := '';
        LastColumn := '';
        MATRIX_CurrentNoOfColumns := 12;

        IF ColumnDimCode = '' THEN
            EXIT;

        CASE ColumnDimCode OF
            Text001:  // Period
                BEGIN
                    MatrixMgt.GeneratePeriodMatrixData(
                      MATRIX_SetWanted, MATRIX_CurrentNoOfColumns, ShowColumnName,
                      PeriodType, DateFilter, MATRIX_PrimKeyFirstCaptionInCu,
                      MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrentNoOfColumns, MATRIX_PeriodRecords);
                    FOR i := 1 TO MATRIX_CurrentNoOfColumns DO BEGIN
                        MATRIX_MatrixRecords[i]."Period Start" := MATRIX_PeriodRecords[i]."Period Start";
                        MATRIX_MatrixRecords[i]."Period End" := MATRIX_PeriodRecords[i]."Period End";
                    END;
                    FirstColumn := FORMAT(MATRIX_PeriodRecords[1]."Period Start");
                    LastColumn := FORMAT(MATRIX_PeriodRecords[MATRIX_CurrentNoOfColumns]."Period End");
                    PeriodTypeEnable := TRUE;
                END;
            GLAccount.TABLECAPTION:
                BEGIN
                    CLEAR(MATRIX_CaptionSet);
                    RecRef.GETTABLE(GLAccount);
                    RecRef.SETTABLE(GLAccount);
                    IF GLAccFilter <> '' THEN BEGIN
                        FieldRef := RecRef.FIELDINDEX(1);
                        FieldRef.SETFILTER(GLAccFilter);
                    END;
                    MatrixMgt.GenerateMatrixData(
                      RecRef, MATRIX_SetWanted, 12, 1,
                      MATRIX_PrimKeyFirstCaptionInCu, MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrentNoOfColumns);
                    FOR i := 1 TO MATRIX_CurrentNoOfColumns DO
                        MATRIX_MatrixRecords[i].Code := COPYSTR(MATRIX_CaptionSet[i], 1, MAXSTRLEN(MATRIX_MatrixRecords[i].Code));
                    IF ShowColumnName THEN
                        MatrixMgt.GenerateMatrixData(
                          RecRef, MATRIX_SetWanted::Same, 12, GLAccount.FIELDNO(Name),
                          MATRIX_PrimKeyFirstCaptionInCu, MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrentNoOfColumns);
                END;
            BusUnit.TABLECAPTION:
                BEGIN
                    CLEAR(MATRIX_CaptionSet);
                    RecRef.GETTABLE(BusUnit);
                    RecRef.SETTABLE(BusUnit);
                    IF BusUnitFilter <> '' THEN BEGIN
                        FieldRef := RecRef.FIELDINDEX(1);
                        FieldRef.SETFILTER(BusUnitFilter);
                    END;
                    MatrixMgt.GenerateMatrixData(
                      RecRef, MATRIX_SetWanted, 12, 1,
                      MATRIX_PrimKeyFirstCaptionInCu, MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrentNoOfColumns);
                    FOR i := 1 TO MATRIX_CurrentNoOfColumns DO
                        MATRIX_MatrixRecords[i].Code := COPYSTR(MATRIX_CaptionSet[i], 1, MAXSTRLEN(MATRIX_MatrixRecords[i].Code));
                    IF ShowColumnName THEN
                        MatrixMgt.GenerateMatrixData(
                          RecRef, MATRIX_SetWanted::Same, 12, BusUnit.FIELDNO(Name),
                          MATRIX_PrimKeyFirstCaptionInCu, MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrentNoOfColumns);
                END;
            // Apply dimension filter
            GLSetup."Global Dimension 1 Code":
                MatrixMgt.GenerateDimColumnCaption(
                  GLSetup."Global Dimension 1 Code",
                  GlobalDim1Filter, MATRIX_SetWanted, MATRIX_PrimKeyFirstCaptionInCu, FirstColumn, LastColumn,
                  MATRIX_CaptionSet, MATRIX_MatrixRecords, MATRIX_CurrentNoOfColumns, ShowColumnName, MATRIX_CaptionRange);
            GLSetup."Global Dimension 2 Code":
                MatrixMgt.GenerateDimColumnCaption(
                  GLSetup."Global Dimension 2 Code",
                  GlobalDim2Filter, MATRIX_SetWanted, MATRIX_PrimKeyFirstCaptionInCu, FirstColumn, LastColumn,
                  MATRIX_CaptionSet, MATRIX_MatrixRecords, MATRIX_CurrentNoOfColumns, ShowColumnName, MATRIX_CaptionRange);
            GLBudgetName."Budget Dimension 1 Code":
                MatrixMgt.GenerateDimColumnCaption(
                  GLBudgetName."Budget Dimension 1 Code",
                  BudgetDim1Filter, MATRIX_SetWanted, MATRIX_PrimKeyFirstCaptionInCu, FirstColumn, LastColumn,
                  MATRIX_CaptionSet, MATRIX_MatrixRecords, MATRIX_CurrentNoOfColumns, ShowColumnName, MATRIX_CaptionRange);
            GLBudgetName."Budget Dimension 2 Code":
                MatrixMgt.GenerateDimColumnCaption(
                  GLBudgetName."Budget Dimension 2 Code",
                  BudgetDim2Filter, MATRIX_SetWanted, MATRIX_PrimKeyFirstCaptionInCu, FirstColumn, LastColumn,
                  MATRIX_CaptionSet, MATRIX_MatrixRecords, MATRIX_CurrentNoOfColumns, ShowColumnName, MATRIX_CaptionRange);
            GLBudgetName."Budget Dimension 3 Code":
                MatrixMgt.GenerateDimColumnCaption(
                  GLBudgetName."Budget Dimension 3 Code",
                  BudgetDim3Filter, MATRIX_SetWanted, MATRIX_PrimKeyFirstCaptionInCu, FirstColumn, LastColumn,
                  MATRIX_CaptionSet, MATRIX_MatrixRecords, MATRIX_CurrentNoOfColumns, ShowColumnName, MATRIX_CaptionRange);
            GLBudgetName."Budget Dimension 4 Code":
                MatrixMgt.GenerateDimColumnCaption(
                  GLBudgetName."Budget Dimension 4 Code",
                  BudgetDim4Filter, MATRIX_SetWanted, MATRIX_PrimKeyFirstCaptionInCu, FirstColumn, LastColumn,
                  MATRIX_CaptionSet, MATRIX_MatrixRecords, MATRIX_CurrentNoOfColumns, ShowColumnName, MATRIX_CaptionRange);
        END;
    end;

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

    local procedure FindPeriod(SearchText: Code[10])
    var
        GLAcc: Record 15;
        Calendar: Record 2000000007;
        PeriodFormMgt: Codeunit 359;
    begin
        IF DateFilter <> '' THEN BEGIN
            Calendar.SETFILTER("Period Start", DateFilter);
            IF NOT PeriodFormMgt.FindDate('+', Calendar, PeriodType) THEN
                PeriodFormMgt.FindDate('+', Calendar, PeriodType::Day);
            Calendar.SETRANGE("Period Start");
        END;
        PeriodFormMgt.FindDate(SearchText, Calendar, PeriodType);
        GLAcc.SETRANGE("Date Filter", Calendar."Period Start", Calendar."Period End");
        IF GLAcc.GETRANGEMIN("Date Filter") = GLAcc.GETRANGEMAX("Date Filter") THEN
            GLAcc.SETRANGE("Date Filter", GLAcc.GETRANGEMIN("Date Filter"));
        InternalDateFilter := GLAcc.GETFILTER("Date Filter");
        IF (LineDimOption <> LineDimOption::Period) AND (ColumnDimOption <> ColumnDimOption::Period) THEN
            DateFilter := InternalDateFilter;
    end;

    local procedure GetDimSelection(OldDimSelCode: Text[30]): Text[30]
    var
        GLAcc: Record 15;
        BusUnit: Record 220;
        DimSelection: Page 568;
    begin
        DimSelection.InsertDimSelBuf(FALSE, GLAcc.TABLECAPTION, GLAcc.TABLECAPTION);
        DimSelection.InsertDimSelBuf(FALSE, BusUnit.TABLECAPTION, BusUnit.TABLECAPTION);
        DimSelection.InsertDimSelBuf(FALSE, Text001, Text001);
        IF GLSetup."Global Dimension 1 Code" <> '' THEN
            DimSelection.InsertDimSelBuf(FALSE, GLSetup."Global Dimension 1 Code", '');
        IF GLSetup."Global Dimension 2 Code" <> '' THEN
            DimSelection.InsertDimSelBuf(FALSE, GLSetup."Global Dimension 2 Code", '');
        IF GLBudgetName."Budget Dimension 1 Code" <> '' THEN
            DimSelection.InsertDimSelBuf(FALSE, GLBudgetName."Budget Dimension 1 Code", '');
        IF GLBudgetName."Budget Dimension 2 Code" <> '' THEN
            DimSelection.InsertDimSelBuf(FALSE, GLBudgetName."Budget Dimension 2 Code", '');
        IF GLBudgetName."Budget Dimension 3 Code" <> '' THEN
            DimSelection.InsertDimSelBuf(FALSE, GLBudgetName."Budget Dimension 3 Code", '');
        IF GLBudgetName."Budget Dimension 4 Code" <> '' THEN
            DimSelection.InsertDimSelBuf(FALSE, GLBudgetName."Budget Dimension 4 Code", '');

        DimSelection.LOOKUPMODE := TRUE;
        IF DimSelection.RUNMODAL = ACTION::LookupOK THEN
            EXIT(DimSelection.GetDimSelCode);

        EXIT(OldDimSelCode);
    end;

    local procedure LookUpDimFilter(Dim: Code[20]; var Text: Text[250]): Boolean
    var
        DimVal: Record 349;
        DimValList: Page 560;
    begin
        IF Dim = '' THEN
            EXIT(FALSE);
        DimValList.LOOKUPMODE(TRUE);
        DimVal.SETRANGE("Dimension Code", Dim);
        DimValList.SETTABLEVIEW(DimVal);
        IF DimValList.RUNMODAL = ACTION::LookupOK THEN BEGIN
            DimValList.GETRECORD(DimVal);
            Text := DimValList.GetSelectionFilter;
        END;
        EXIT(TRUE);
    end;

    local procedure DeleteBudget()
    var
        GLBudgetEntry: Record 96;
        UpdateAnalysisView: Codeunit 410;
    begin
        IF CONFIRM(Text003) THEN BEGIN
            SETRANGE("Budget Name", BudgetName);
            IF BusUnitFilter <> '' THEN
                SETFILTER("Business Unit Code", BusUnitFilter);
            IF GLAccFilter <> '' THEN
                SETFILTER("G/L Account No.", GLAccFilter);
            IF DateFilter <> '' THEN
                SETFILTER(Date, DateFilter);
            IF GlobalDim1Filter <> '' THEN
                SETFILTER("Global Dimension 1 Code", GlobalDim1Filter);
            IF GlobalDim2Filter <> '' THEN
                SETFILTER("Global Dimension 2 Code", GlobalDim2Filter);
            IF BudgetDim1Filter <> '' THEN
                SETFILTER("Budget Dimension 1 Code", BudgetDim1Filter);
            IF BudgetDim2Filter <> '' THEN
                SETFILTER("Budget Dimension 2 Code", BudgetDim2Filter);
            IF BudgetDim3Filter <> '' THEN
                SETFILTER("Budget Dimension 3 Code", BudgetDim3Filter);
            IF BudgetDim4Filter <> '' THEN
                SETFILTER("Budget Dimension 4 Code", BudgetDim4Filter);
            SETCURRENTKEY("Entry No.");
            IF FINDFIRST THEN
                UpdateAnalysisView.SetLastBudgetEntryNo("Entry No." - 1);
            SETCURRENTKEY("Budget Name");
            DELETEALL(TRUE);
        END;
    end;

    local procedure ValidateBudgetName()
    begin
        GLBudgetName.Name := BudgetName;
        IF NOT GLBudgetName.FIND('=<>') THEN BEGIN
            GLBudgetName.INIT;
            GLBudgetName.Name := Text004;
            GLBudgetName.Description := Text005;
            GLBudgetName.INSERT;
        END;
        BudgetName := GLBudgetName.Name;
        GLAccBudgetBuf.SETRANGE("Budget Filter", BudgetName);
        IF PrevGLBudgetName.Name <> '' THEN BEGIN
            IF GLBudgetName."Budget Dimension 1 Code" <> PrevGLBudgetName."Budget Dimension 1 Code" THEN
                BudgetDim1Filter := '';
            IF GLBudgetName."Budget Dimension 2 Code" <> PrevGLBudgetName."Budget Dimension 2 Code" THEN
                BudgetDim2Filter := '';
            IF GLBudgetName."Budget Dimension 3 Code" <> PrevGLBudgetName."Budget Dimension 3 Code" THEN
                BudgetDim3Filter := '';
            IF GLBudgetName."Budget Dimension 4 Code" <> PrevGLBudgetName."Budget Dimension 4 Code" THEN
                BudgetDim4Filter := '';
        END;
        GLAccBudgetBuf.SETFILTER("Budget Dimension 1 Filter", BudgetDim1Filter);
        GLAccBudgetBuf.SETFILTER("Budget Dimension 2 Filter", BudgetDim2Filter);
        GLAccBudgetBuf.SETFILTER("Budget Dimension 3 Filter", BudgetDim3Filter);
        GLAccBudgetBuf.SETFILTER("Budget Dimension 4 Filter", BudgetDim4Filter);
        BudgetDim1FilterEnable := (GLBudgetName."Budget Dimension 1 Code" <> '');
        BudgetDim2FilterEnable := (GLBudgetName."Budget Dimension 2 Code" <> '');
        BudgetDim3FilterEnable := (GLBudgetName."Budget Dimension 3 Code" <> '');
        BudgetDim4FilterEnable := (GLBudgetName."Budget Dimension 4 Code" <> '');

        PrevGLBudgetName := GLBudgetName;
    end;

    local procedure ValidateLineDimCode()
    var
        BusUnit: Record 220;
        GLAcc: Record 15;
    begin
        IF (UPPERCASE(LineDimCode) <> UPPERCASE(GLAcc.TABLECAPTION)) AND
           (UPPERCASE(LineDimCode) <> UPPERCASE(BusUnit.TABLECAPTION)) AND
           (UPPERCASE(LineDimCode) <> UPPERCASE(Text001)) AND
           (UPPERCASE(LineDimCode) <> GLBudgetName."Budget Dimension 1 Code") AND
           (UPPERCASE(LineDimCode) <> GLBudgetName."Budget Dimension 2 Code") AND
           (UPPERCASE(LineDimCode) <> GLBudgetName."Budget Dimension 3 Code") AND
           (UPPERCASE(LineDimCode) <> GLBudgetName."Budget Dimension 4 Code") AND
           (UPPERCASE(LineDimCode) <> GLSetup."Global Dimension 1 Code") AND
           (UPPERCASE(LineDimCode) <> GLSetup."Global Dimension 2 Code") AND
           (LineDimCode <> '')
        THEN BEGIN
            MESSAGE(Text006, LineDimCode);
            LineDimCode := '';
        END;
        LineDimOption := DimCodeToOption(LineDimCode);
        DateFilter := InternalDateFilter;
        IF (LineDimOption <> LineDimOption::Period) AND (ColumnDimOption <> ColumnDimOption::Period) THEN BEGIN
            DateFilter := InternalDateFilter;
            IF STRPOS(DateFilter, '&') > 1 THEN
                DateFilter := COPYSTR(DateFilter, 1, STRPOS(DateFilter, '&') - 1);
        END ELSE
            DateFilter := '';
    end;

    local procedure ValidateColumnDimCode()
    var
        BusUnit: Record 220;
        GLAcc: Record 15;
    begin
        IF (UPPERCASE(ColumnDimCode) <> UPPERCASE(GLAcc.TABLECAPTION)) AND
           (UPPERCASE(ColumnDimCode) <> UPPERCASE(BusUnit.TABLECAPTION)) AND
           (UPPERCASE(ColumnDimCode) <> UPPERCASE(Text001)) AND
           (UPPERCASE(ColumnDimCode) <> GLBudgetName."Budget Dimension 1 Code") AND
           (UPPERCASE(ColumnDimCode) <> GLBudgetName."Budget Dimension 2 Code") AND
           (UPPERCASE(ColumnDimCode) <> GLBudgetName."Budget Dimension 3 Code") AND
           (UPPERCASE(ColumnDimCode) <> GLBudgetName."Budget Dimension 4 Code") AND
           (UPPERCASE(ColumnDimCode) <> GLSetup."Global Dimension 1 Code") AND
           (UPPERCASE(ColumnDimCode) <> GLSetup."Global Dimension 2 Code") AND
           (ColumnDimCode <> '')
        THEN BEGIN
            MESSAGE(Text007, ColumnDimCode);
            ColumnDimCode := '';
        END;
        ColumnDimOption := DimCodeToOption(ColumnDimCode);
        DateFilter := InternalDateFilter;
        IF (LineDimOption <> LineDimOption::Period) AND (ColumnDimOption <> ColumnDimOption::Period) THEN BEGIN
            DateFilter := InternalDateFilter;
            IF STRPOS(DateFilter, '&') > 1 THEN
                DateFilter := COPYSTR(DateFilter, 1, STRPOS(DateFilter, '&') - 1);
        END ELSE
            DateFilter := '';
    end;

    local procedure GetCaptionClass(BudgetDimType: Integer): Text[250]
    begin
        IF GLBudgetName.Name <> BudgetName THEN
            GLBudgetName.GET(BudgetName);
        CASE BudgetDimType OF
            1:
                BEGIN
                    IF GLBudgetName."Budget Dimension 1 Code" <> '' THEN
                        EXIT('1,6,' + GLBudgetName."Budget Dimension 1 Code");

                    EXIT(Text008);
                END;
            2:
                BEGIN
                    IF GLBudgetName."Budget Dimension 2 Code" <> '' THEN
                        EXIT('1,6,' + GLBudgetName."Budget Dimension 2 Code");

                    EXIT(Text009);
                END;
            3:
                BEGIN
                    IF GLBudgetName."Budget Dimension 3 Code" <> '' THEN
                        EXIT('1,6,' + GLBudgetName."Budget Dimension 3 Code");

                    EXIT(Text010);
                END;
            4:
                BEGIN
                    IF GLBudgetName."Budget Dimension 4 Code" <> '' THEN
                        EXIT('1,6,' + GLBudgetName."Budget Dimension 4 Code");

                    EXIT(Text011);
                END;
        END;
    end;

    procedure SetBudgetName(NextBudgetName: Code[10])
    begin
        NewBudgetName := NextBudgetName;
    end;

    procedure SetGLAccountFilter(NewGLAccFilter: Code[250])
    begin
        GLAccFilter := NewGLAccFilter;
        GLAccFilterOnAfterValidate;
    end;

    local procedure UpdateMatrixSubform()
    begin
        CurrPage.MatrixForm.PAGE.Load(
          MATRIX_CaptionSet, MATRIX_MatrixRecords, MATRIX_CurrentNoOfColumns, LineDimCode,
          LineDimOption, ColumnDimOption, GlobalDim1Filter, GlobalDim2Filter, BudgetDim1Filter,
          BudgetDim2Filter, BudgetDim3Filter, BudgetDim4Filter, GLBudgetName, DateFilter,
          GLAccFilter, RoundingFactor, PeriodType);

        CurrPage.UPDATE;
    end;

    local procedure LineDimCodeOnAfterValidate()
    begin
        UpdateMatrixSubform;
    end;

    local procedure ColumnDimCodeOnAfterValidate()
    begin
        UpdateMatrixSubform;
    end;

    local procedure PeriodTypeOnAfterValidate()
    var
        MATRIX_Step: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
    begin
        IF ColumnDimOption = ColumnDimOption::Period THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);
        UpdateMatrixSubform;
    end;

    local procedure GLAccFilterOnAfterValidate()
    begin
        GLAccBudgetBuf.SETFILTER("G/L Account Filter", GLAccFilter);
        IF ColumnDimOption = ColumnDimOption::"G/L Account" THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);
        UpdateMatrixSubform;
    end;

    local procedure GlobalDim2FilterOnAfterValidat()
    begin
        GLAccBudgetBuf.SETFILTER("Global Dimension 2 Filter", GlobalDim2Filter);
        IF ColumnDimOption = ColumnDimOption::"Global Dimension 2" THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);
        UpdateMatrixSubform;
    end;

    local procedure GlobalDim1FilterOnAfterValidat()
    begin
        GLAccBudgetBuf.SETFILTER("Global Dimension 1 Filter", GlobalDim1Filter);
        IF ColumnDimOption = ColumnDimOption::"Global Dimension 1" THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);
        UpdateMatrixSubform;
    end;

    local procedure BudgetDim2FilterOnAfterValidat()
    begin
        GLAccBudgetBuf.SETFILTER("Budget Dimension 2 Filter", BudgetDim2Filter);
        IF ColumnDimOption = ColumnDimOption::"Budget Dimension 2" THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);
        UpdateMatrixSubform;
    end;

    local procedure BudgetDim1FilterOnAfterValidat()
    begin
        GLAccBudgetBuf.SETFILTER("Budget Dimension 1 Filter", BudgetDim1Filter);
        IF ColumnDimOption = ColumnDimOption::"Budget Dimension 1" THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);
        UpdateMatrixSubform;
    end;

    local procedure BudgetDim4FilterOnAfterValidat()
    begin
        GLAccBudgetBuf.SETFILTER("Budget Dimension 4 Filter", BudgetDim4Filter);
        IF ColumnDimOption = ColumnDimOption::"Budget Dimension 4" THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);
        UpdateMatrixSubform;
    end;

    local procedure BudgetDim3FilterOnAfterValidat()
    begin
        GLAccBudgetBuf.SETFILTER("Budget Dimension 3 Filter", BudgetDim3Filter);
        IF ColumnDimOption = ColumnDimOption::"Budget Dimension 3" THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);
        UpdateMatrixSubform;
    end;

    local procedure DateFilterOnAfterValidate()
    begin
        IF ColumnDimOption = ColumnDimOption::Period THEN
            MATRIX_GenerateColumnCaptions(MATRIX_Step::Initial);
        UpdateMatrixSubform;
    end;

    local procedure ShowColumnNameOnPush()
    var
        MATRIX_Step: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
    begin
        MATRIX_GenerateColumnCaptions(MATRIX_Step::Same);
        UpdateMatrixSubform;
    end;
} */

