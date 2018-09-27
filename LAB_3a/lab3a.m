function varargout = lab3a(varargin)

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

global Folder;
Folder = uigetdir('*','Select directory of a files');
global Image_fullname;
Image_fullname = dir(strcat(Folder,'\*','.png'));
set(handles.folder,'string','Images Loaded','enable','off');
end

function train_Callback(hObject, eventdata, handles)

global Folder;
global Image_fullname;
global mat;
global imagename;
global class;
mat = zeros(2952,59);
for i = 1: length(Image_fullname)
    image = strcat(Folder,'\',Image_fullname(i).name);
    nam = Image_fullname(i).name;
    expression = '[^\D+]';
    something = regexp(nam,expression,'match');
    imagename{i,1} = something;
    id = rgb2gray(imread(image));
    mat(i,:) = extractLBPFeatures(id);
end
xlswrite('training.xlsx',mat);
set(handles.train,'string','Feature Extracted','enable','off');
end

function query_Callback(hObject, eventdata, handles)

[filename, filepath] = uigetfile('*.png','Search Image to be displayed');
fullname = [filepath filename];
img = imread(fullname);
id = rgb2gray(img);
global feature;
feature = extractLBPFeatures(id);
imshow(img);
end

function display_Callback(hObject, eventdata, handles)

global imagename;
global mat;
global db;
global Folder;
global Image_fullname;
global feature;

tree = fitctree(mat,imagename);
view(tree,'mode','graph');
res = predict(tree,feature);


end

function db_Callback(hObject, eventdata, handles)

[filename, filepath] = uigetfile('*.xlsx','Select feature database');
fullname = [filepath filename];
global db;
db = xlsread(fullname);
set(handles.db,'string','Database Loaded','enable','off');
end
