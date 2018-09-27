function varargout = lab3aV2(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @lab3a_OpeningFcn, ...
    'gui_OutputFcn',  @lab3a_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);

if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
end

function lab3a_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);
end

function varargout = lab3a_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;
end

function folder_Callback(hObject, eventdata, handles)

global Directory;
global TrainingImage;

Directory = uigetdir('*','Select directory of a files');
TrainingImage = dir(strcat(Directory,'\*','.png'));
set(handles.folder,'string','Images Loaded','enable','off');
end

function train_Callback(hObject, eventdata, handles)

global TrainingImage;
global LBP;
global ImageName;
global Directory;

ImageName = string(length(TrainingImage));

for i = 1: length(TrainingImage)
    Image = strcat(Directory,'\',TrainingImage(i).name);
    
    FileName = TrainingImage(i).name;
    NameImage = strsplit(FileName,{'0','1','2','3','4','5','6','7','8','9'});
    
    SplitName = NameImage(1);
    
    ImageName{i,1} = char(SplitName{1});
    id = rgb2gray(imread(Image));
    LBP(i,:) = extractLBPFeatures(id);
end
%xlswrite('Training Names.xlsx', ImageName);
xlswrite('Features.xlsx',LBP);
set(handles.train,'string','Feature Extracted','enable','off');
end


function db_Callback(hObject, eventdata, handles)

global db;

[filename, filepath] = uigetfile('*.xlsx','Select feature database');
fullname = [filepath filename];

db = xlsread(fullname);
set(handles.db,'string','Database Loaded','enable','off');
end

function query_Callback(hObject, eventdata, handles)
global Query;
global TestFolder;
global Query_Image_Fullname;

TestFolder = uigetdir('*','Select directory of files');
Query_Image_Fullname = dir(strcat(TestFolder,'\*','.png'));

for i = 1: length(Query_Image_Fullname)
    image = strcat(TestFolder,'\',Query_Image_Fullname(i).name);
    id = rgb2gray(imread(image));
    Query(i,:) = extractLBPFeatures(id);
end
%xlswrite('Query Features.xlsx',Query);
set(handles.query,'string','Query Loaded','enable','off');
end

function display_Callback(hObject, eventdata, handles)

global LBP;
global Query;
global ImageName;
global Query_Image_Fullname;

DiscisionTree = fitctree(LBP,ImageName);
view(DiscisionTree,'mode','graph');
for i = 1:length(Query_Image_Fullname)
    w(i,1)= predict(DiscisionTree,Query(i,:));
end
xlswrite('Output.xlsx',w);
set(handles.display,'string','Work done!','enable','off');
end
