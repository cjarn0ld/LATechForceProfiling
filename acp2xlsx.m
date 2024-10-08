%% Directory with acp files
folderPath = "C:\Users\User\OneDrive\Desktop\lmj_sep_18";
files = dir(fullfile(folderPath, '*.acp'));

%% Set up the Import Options
opts = delimitedTextImportOptions("NumVariables", 17);
opts.DataLines = [2, Inf];
opts.Delimiter = "\t";
opts.VariableNames = ["Time (s)", "Raw Fx-R (N)", "Raw Fy-R (N)", "Raw Fz-R (N)", "Raw Mx-R (Nm)", "Raw My-R (Nm)", "Raw Mz-R (Nm)", "Raw Fx-L (N)", "Raw Fy-L (N)", "Raw Fz-L (N)", "Raw Mx-L (Nm)", "Raw My-L (Nm)", "Raw Mz-L (Nm)", "COP X-L", "COP Y-L", "COP X-R", "COP Y-R"];
opts.VariableTypes = repmat({'double'}, 1, 17);
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";


%% Loop through each file and import data
for k = 1:length(files)
    fullPath = fullfile(files(k).folder, files(k).name);
    
    % Import the data
    tbl = readtable(fullPath, opts);
    
    % Create an Excel filename based on the original filename
    [filePath, name, ~] = fileparts(fullPath);
    excelFilename = fullfile(filePath, strcat(name, '.xlsx'));
    
    % Save the table to Excel
    writetable(tbl, excelFilename);
end

%% Clear temporary variables
clear opts;
