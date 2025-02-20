codeunit 40007 "Export Excell Mrp"
{
    trigger OnRun()

    begin
        DonwloadExcelFile();
    end;

    local procedure DonwloadExcelFile()
    var
        instrm: InStream;
        Outstrm: OutStream;
        TempBlob: Codeunit "Temp Blob";
        record: text;
        sheetName: Text;
        FileType: label 'All Files "+"|"-"';
        FileName: Text;

        TmpExcelBuf: Record "Excel Buffer" temporary;
        mrp: Record "Clinical rotation";
    begin
        Clear(TmpExcelBuf);
        TmpExcelBuf.Reset();
        TmpExcelBuf.DeleteAll();

        TmpExcelBuf.NewRow();
        TmpExcelBuf.AddColumn(mrp.FieldCaption("Plan ID"), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Number);
        TmpExcelBuf.AddColumn(mrp.FieldCaption(Group), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(mrp.FieldCaption(Areas), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);
        TmpExcelBuf.AddColumn(mrp.FieldCaption("Assessment Start Date"), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::date);
        TmpExcelBuf.AddColumn(mrp.FieldCaption("Assessment End Date"), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Date);
        TmpExcelBuf.AddColumn(mrp.FieldCaption(Month), false, '', true, false, false, '', TmpExcelBuf."Cell Type"::Text);


        if mrp.FindSet() then begin
            repeat
                TmpExcelBuf.NewRow();
                //mrp.CalcFields("No Of Students")
                TmpExcelBuf.AddColumn(mrp."Plan ID", false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Number);
                TmpExcelBuf.AddColumn(mrp.Group, false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Text);
                TmpExcelBuf.AddColumn(mrp.Areas, false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Number);
                TmpExcelBuf.AddColumn(mrp."Assessment Start Date", false, '', false, false, false, '', TmpExcelBuf."Cell Type"::date);
                TmpExcelBuf.AddColumn(mrp."Assessment End Date", false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Date);
                TmpExcelBuf.AddColumn(mrp.Month, false, '', false, false, false, '', TmpExcelBuf."Cell Type"::Number);

            Until mrp.Next() = 0;


            sheetName := 'Mrp Template';
            FileName := 'MrpTemplate.xlsx';
            TmpExcelBuf.CreateNewBook(sheetName);
            TmpExcelBuf.WriteSheet(sheetName, CompanyName, UserId);
            TmpExcelBuf.CloseBook();

            TempBlob.CreateOutStream(Outstrm);
            TmpExcelBuf.SaveToStream(Outstrm, false);
            TempBlob.CreateInStream(instrm);


            DownloadFromStream(instrm, 'Download Excel', '', FileType, FileName)




        end;

    end;

}
