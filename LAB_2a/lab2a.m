function varargout = lab2a(varargin)
% LAB2A MATLAB code for lab2a.fig
%      LAB2A, by itself, creates a new LAB2A or raises the existing
%      singleton*.
%
%      H = LAB2A returns the handle to a new LAB2A or the handle to
%      the existing singleton*.
%
%      LAB2A('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAB2A.M with the given input arguments.
%
%      LAB2A('Property','Value',...) creates a new LAB2A or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lab2a_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lab2a_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lab2a

% Last Modified by GUIDE v2.5 22-Sep-2018 09:26:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @lab2a_OpeningFcn, ...
    'gui_OutputFcn',  @lab2a_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before lab2a is made visible.
function lab2a_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lab2a (see VARARGIN)

% Choose default command line output for lab2a
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lab2a wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lab2a_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in folder.
function folder_Callback(hObject, eventdata, handles)
% hObject    handle to folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Folder;
Folder = uigetdir('*','Select directory of a files');
global Image_fullname;
Image_fullname = dir(strcat(Folder,'\*','.png'));
set(handles.folder,'string','Images Loaded','enable','off');


% --- Executes on button press in train.
function train_Callback(hObject, eventdata, handles)
% hObject    handle to train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Folder;
global Image_fullname;
global mat;
for i = 1: length(Image_fullname)
    image = strcat(Folder,'\',Image_fullname(i).name);
    id = im2double(rgb2gray(imread(image)));
    mat(i,1) = i;
    imean = mean(id(:));
    mat(i,2) = imean;
    imedian = median(id(:));
    mat(i,3) = imedian;
    imode = mode(id(:));
    mat(i,4) = imode;
    imid = ((max(id(:))+min(id(:)))/2);
    mat(i,5) = imid;
    irange = range(id(:));
    mat(i,6) = irange;
    iIQR = iqr(id(:));
    mat(i,7) = iIQR;
    istd = std(id(:));
    mat(i,8) = istd;
end
xlswrite('training.xlsx',mat);
set(handles.train,'string','Feature Extracted','enable','off');

% --- Executes on button press in query.
function query_Callback(hObject, eventdata, handles)
% hObject    handle to query (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, filepath] = uigetfile('*.png','Search Image to be displayed');
fullname = [filepath filename];
img = imread(fullname);
id = im2double(rgb2gray(img));
global m;
m(1,1) = 0;
imean = mean(id(:));
m(1,2) = imean;
imedian = median(id(:));
m(1,3) = imedian;
imode = mode(id(:));
m(1,4) = imode;
imid = ((max(id(:))+min(id(:)))/2);
m(1,5) = imid;
irange = range(id(:));
m(1,6) = irange;
iIQR = iqr(id(:));
m(1,7) = iIQR;
istd = std(id(:));
m(1,8) = istd;
axes(handles.axes1);
imshow(img);

% --- Executes on button press in display.
function display_Callback(hObject, eventdata, handles)
% hObject    handle to display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m;
global db;
global Folder;
global Image_fullname;
for i = 1:length(Image_fullname)
    dis = 0;
    for j = 2:8
        x = m(1,j);
        y = db(i,j);
        dis = dis + abs(x-y);
    end
    cb(i,1) = i;
    cb(i,2) = dis;
end
[E,index] = sortrows(cb,2,'ascend');
for i = 1: 20
    n = index(i,1);
    image = strcat(Folder,'\',Image_fullname(n).name);
    axes(handles.(['axes',num2str(i+1)]));
    imshow(imread(image));
end

% --- Executes on button press in db.
function db_Callback(hObject, eventdata, handles)
% hObject    handle to db (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, filepath] = uigetfile('*.xlsx','Select feature database');
fullname = [filepath filename];
global db;
db = xlsread(fullname);
set(handles.db,'string','Database Loaded','enable','off');
