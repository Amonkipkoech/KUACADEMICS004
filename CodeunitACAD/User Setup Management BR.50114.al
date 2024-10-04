codeunit 50114 "User Setup Management ACA"
{
    Permissions = TableData 14 = r,
                  TableData 5714 = r;

    trigger OnRun()
    begin
    end;

    var
        Text000: Label 'customer';
        Text001: Label 'vendor';
        Text002: Label 'This %1 is related to %2 %3. Your identification is setup to process from %2 %4.';
        Text003: Label 'This document will be processed in your %2.';
        UserSetup: Record 91;
        RespCenter: Record 61533;
        CompanyInfo: Record 79;
        UserLocation: Code[10];
        UserRespCenter: Code[10];
        SalesUserRespCenter: Code[10];
        PurchUserRespCenter: Code[10];
        ServUserRespCenter: Code[10];
        HasGotSalesUserSetup: Boolean;
        HasGotPurchUserSetup: Boolean;
        HasGotServUserSetup: Boolean;
        DimensionVal: Code[20];

    //[Scope('Internal')]
    /// <summary>
    /// GetSalesFilter.
    /// </summary>
    /// <returns>Return value of type Code[10].</returns>
    procedure GetSalesFilter(): Code[10]
    begin
        EXIT(GetSalesFilter2(USERID));
    end;

    //[Scope('Internal')]
    /// <summary>
    /// GetPurchasesFilter.
    /// </summary>
    /// <returns>Return value of type Code[10].</returns>
    procedure GetPurchasesFilter(): Code[10]
    begin
        EXIT(GetPurchasesFilter2(USERID));
    end;

    //[Scope('Internal')]
    /// <summary>
    /// GetServiceFilter.
    /// </summary>
    /// <returns>Return value of type Code[10].</returns>
    procedure GetServiceFilter(): Code[10]
    begin
        EXIT(GetServiceFilter2(USERID));
    end;

    //[Scope('Internal')]
    /// <summary>
    /// GetSalesFilter2.
    /// </summary>
    /// <param name="UserCode">Code[20].</param>
    /// <returns>Return value of type Code[10].</returns>
    procedure GetSalesFilter2(UserCode: Code[20]): Code[10]
    begin
        IF NOT HasGotSalesUserSetup THEN BEGIN
            CompanyInfo.GET;
            SalesUserRespCenter := CompanyInfo."Responsibility Center";
            UserLocation := CompanyInfo."Location Code";
            IF (UserSetup.GET(UserCode)) AND (UserCode <> '') THEN
                IF UserSetup."Sales Resp. Ctr. Filter" <> '' THEN
                    SalesUserRespCenter := UserSetup."Sales Resp. Ctr. Filter";
            HasGotSalesUserSetup := TRUE;
        END;
        EXIT(SalesUserRespCenter);
    end;

    //[Scope('Internal')]
    /// <summary>
    /// GetPurchasesFilter2.
    /// </summary>
    /// <param name="UserCode">Code[30].</param>
    /// <returns>Return value of type Code[10].</returns>
    procedure GetPurchasesFilter2(UserCode: Code[30]): Code[10]
    begin
        IF NOT HasGotPurchUserSetup THEN BEGIN
            CompanyInfo.GET;
            PurchUserRespCenter := CompanyInfo."Responsibility Center";
            UserLocation := CompanyInfo."Location Code";
            IF (UserSetup.GET(UserCode)) AND (UserCode <> '') THEN
                IF UserSetup."Purchase Resp. Ctr. Filter" <> '' THEN
                    PurchUserRespCenter := UserSetup."Purchase Resp. Ctr. Filter";
            HasGotPurchUserSetup := TRUE;
        END;
        EXIT(PurchUserRespCenter);
    end;

    //[Scope('Internal')]
    /// <summary>
    /// GetServiceFilter2.
    /// </summary>
    /// <param name="UserCode">Code[20].</param>
    /// <returns>Return value of type Code[10].</returns>
    procedure GetServiceFilter2(UserCode: Code[20]): Code[10]
    begin
        IF NOT HasGotServUserSetup THEN BEGIN
            CompanyInfo.GET;
            ServUserRespCenter := CompanyInfo."Responsibility Center";
            UserLocation := CompanyInfo."Location Code";
            IF (UserSetup.GET(UserCode)) AND (UserCode <> '') THEN
                IF UserSetup."Service Resp. Ctr. Filter" <> '' THEN
                    ServUserRespCenter := UserSetup."Service Resp. Ctr. Filter";
            HasGotServUserSetup := TRUE;
        END;
        EXIT(ServUserRespCenter);
    end;

    //[Scope('Internal')]
    /// <summary>
    /// GetRespCenter.
    /// </summary>
    /// <param name="DocType">Option Sales,Purchase,Service.</param>
    /// <param name="AccRespCenter">Code[10].</param>
    /// <returns>Return value of type Code[10].</returns>
    procedure GetRespCenter(DocType: Option Sales,Purchase,Service; AccRespCenter: Code[10]): Code[10]
    var
        AccType: Text[50];
    begin
        CASE DocType OF
            DocType::Sales:
                BEGIN
                    AccType := Text000;
                    UserRespCenter := GetSalesFilter;
                END;
            DocType::Purchase:
                BEGIN
                    AccType := Text001;
                    UserRespCenter := GetPurchasesFilter;
                END;
            DocType::Service:
                BEGIN
                    AccType := Text000;
                    UserRespCenter := GetServiceFilter;
                END;
        END;
        IF (AccRespCenter <> '') AND
           (UserRespCenter <> '') AND
           (AccRespCenter <> UserRespCenter)
        THEN
            MESSAGE(
              Text002 +
              Text003,
              AccType, RespCenter.TABLECAPTION, AccRespCenter, UserRespCenter);
        IF UserRespCenter = '' THEN
            EXIT(AccRespCenter)
        ELSE
            EXIT(UserRespCenter);
    end;

    //[Scope('Internal')]
    /// <summary>
    /// CheckRespCenter.
    /// </summary>
    /// <param name="DocType">Option Sales,Purchase,Service.</param>
    /// <param name="AccRespCenter">Code[10].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure CheckRespCenter(DocType: Option Sales,Purchase,Service; AccRespCenter: Code[10]): Boolean
    begin
        EXIT(CheckRespCenter2(DocType, AccRespCenter, USERID));
    end;

    //[Scope('Internal')]
    /// <summary>
    /// CheckRespCenter2.
    /// </summary>
    /// <param name="DocType">Option Sales,Purchase,Service.</param>
    /// <param name="AccRespCenter">Code[20].</param>
    /// <param name="UserCode">Code[20].</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure CheckRespCenter2(DocType: Option Sales,Purchase,Service; AccRespCenter: Code[20]; UserCode: Code[20]): Boolean
    begin
        CASE DocType OF
            DocType::Sales:
                UserRespCenter := GetSalesFilter2(UserCode);
            DocType::Purchase:
                UserRespCenter := GetPurchasesFilter2(UserCode);
            DocType::Service:
                UserRespCenter := GetServiceFilter2(UserCode);
        END;
        IF (UserRespCenter <> '') AND
           (AccRespCenter <> UserRespCenter)
        THEN
            EXIT(FALSE)
        ELSE
            EXIT(TRUE);
    end;

    //[Scope('Internal')]
    /// <summary>
    /// GetLocation.
    /// </summary>
    /// <param name="DocType">Option Sales,Purchase,Service.</param>
    /// <param name="AccLocation">Code[10].</param>
    /// <param name="RespCenterCode">Code[10].</param>
    /// <returns>Return value of type Code[10].</returns>
    procedure GetLocation(DocType: Option Sales,Purchase,Service; AccLocation: Code[10]; RespCenterCode: Code[10]): Code[10]
    begin
        CASE DocType OF
            DocType::Sales:
                UserRespCenter := GetSalesFilter;
            DocType::Purchase:
                UserRespCenter := GetPurchasesFilter;
            DocType::Service:
                UserRespCenter := GetServiceFilter;
        END;
        IF UserRespCenter <> '' THEN
            RespCenterCode := UserRespCenter;
        IF RespCenter.GET(RespCenterCode) THEN
            IF RespCenter."Distribution Account" <> '' THEN
                UserLocation := RespCenter."Distribution Account";
        IF AccLocation <> '' THEN
            EXIT(AccLocation)
        ELSE
            EXIT(UserLocation);
    end;

    //[Scope('Internal')]
    /// <summary>
    /// GetSetDimensions.
    /// </summary>
    /// <param name="UserCode">Code[30].</param>
    /// <param name="DimensionNo">Integer.</param>
    /// <returns>Return value of type Code[10].</returns>
    procedure GetSetDimensions(UserCode: Code[30]; DimensionNo: Integer): Code[10]
    begin
        DimensionVal := '';
        CASE DimensionNo OF
            1:
                BEGIN
                    IF (UserSetup.GET(UserCode)) AND (UserCode <> '') THEN
                        IF UserSetup."Global Dimension 1 Code" <> '' THEN
                            DimensionVal := UserSetup."Global Dimension 1 Code";
                    EXIT(DimensionVal);
                END;
            2:
                BEGIN
                    IF (UserSetup.GET(UserCode)) AND (UserCode <> '') THEN
                        IF UserSetup.tetst <> '' THEN
                            DimensionVal := UserSetup.tetst;
                    EXIT(DimensionVal);
                END;
            3:
                BEGIN
                    IF (UserSetup.GET(UserCode)) AND (UserCode <> '') THEN
                        IF UserSetup."Shortcut Dimension 3 Code" <> '' THEN
                            DimensionVal := UserSetup."Shortcut Dimension 3 Code";
                    EXIT(DimensionVal);
                END;
            4:
                BEGIN
                    IF (UserSetup.GET(UserCode)) AND (UserCode <> '') THEN
                        IF UserSetup."Shortcut Dimension 4 Code" <> '' THEN
                            DimensionVal := UserSetup."Shortcut Dimension 4 Code";
                    EXIT(DimensionVal);
                END;
        END;
    end;
}