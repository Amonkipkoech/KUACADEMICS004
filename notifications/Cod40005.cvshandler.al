codeunit 40005 "Csv Handler"
{
    procedure ExportCsvFile(FileName: Text[250]; RecRef: RecordRef; arrFieldRef: array[20] of FieldRef; FieldRefLength: Integer);
    var
        txtvalue: Text;
        CsvBuffer: Record "CSV Buffer" temporary;
        LineNo: Integer;
        index: Integer;
        xFieldRef: FieldRef;
        ToFileTxt: Text;
        filemgmt: Codeunit "File Management";
        FACard: page "Fixed Asset Card";
    begin
        FileName := DelChr(FileName, '=', '/');
        FileName := 'C:\' + FileName + '.csv';
        if exists(FileName) then
            Erase(FileName);
        for index := 1 to FieldRefLength do begin
            LineNo := 1;
            CsvBuffer.InsertEntry(LineNo, index, arrFieldRef[index].Caption);
        end;
        if not RecRef.IsEmpty and not RecRef.IsDirty then begin
            if RecRef.FindSet() then begin
                repeat
                    Clear(index);
                    LineNo += 1;
                    for index := 1 to FieldRefLength do begin
                        xFieldRef := RecRef.Field(arrFieldRef[index].Number);
                        txtvalue := FormatFieldValue(xFieldRef);
                        CsvBuffer.InsertEntry(LineNo, index, txtvalue);
                    end;
                until RecRef.Next() = 0;
            end;
        end;
        CsvBuffer.SaveData(filename, ',');
        if Exists(filename) then begin
            ToFileTxt := CopyStr(FileName, 4, StrLen(filemgmt.GetFileNameWithoutExtension(FileName)));
            Download(filename, 'Save Valuation as', 'C:\', '*.csv', ToFileTxt);
        end;
    end;

    procedure ImportCsvFile(FileName: Text[250]; RecRef: RecordRef; arrFieldRef: array[20] of FieldRef; FieldRefLength: Integer);
    var
        CsvBuffer: Record "CSV Buffer" temporary;
        LineNo: Integer;
        i: Integer;
        xFieldRef: FieldRef;
        FromFileTxt: Text;
        filemgmt: Codeunit "File Management";
    begin
        FileName := filemgmt.UploadFile('Upload Csv file to Import', '*.csv');
        if FileName <> '' then begin
            CsvBuffer.LoadData(FileName, ',');
            if CsvBuffer.FindSet() then begin
                repeat
                    if CsvBuffer."Line No." > 1 then begin
                        if CsvBuffer."Field No." = 1 then
                            RecRef.Init();
                        for i := 1 to FieldRefLength do begin
                            xFieldRef := RecRef.field(arrFieldRef[i].Number);
                            if CsvBuffer.Value <> '' then
                                xFieldRef.Value := CsvBuffer."Value";
                        end;
                        if not RecRef.Insert(true) then
                            RecRef.Modify(true);
                    end;
                until CsvBuffer.Next() = 0;
            end;
        end;
    end;

    local procedure FormatFieldValue(FieldRef: FieldRef): Text
    var
        Value: Text;
    begin
        case FieldRef.TYPE of
            FieldRef.Type::Text,
            FieldRef.Type::Code:
                begin
                    Value := Format(FieldRef.Value);
                    if Value.Contains(',') then
                        Value := '"' + Value.Replace('"', '""') + '"';
                end;
            FieldRef.Type::Date:
                Value := Format(FieldRef.Value, 0, '<Year4>-<Month,2>-<Day,2>');
            FieldRef.Type::DateTime:
                Value := Format(FieldRef.Value, 0, '<Year4>-<Month,2>-<Day,2> <Hours24,2>:<Minutes,2>:<Seconds,2>');
            FieldRef.Type::Decimal:
                Value := Format(FieldRef.Value, 0, '<Precision,2:2><Standard Format,0>');
            else
                Value := Format(FieldRef.Value);
        end;
        exit(Value);
    end;
}
