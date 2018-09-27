function varargout = mas_classify(varargin)
% MAS_CLASSIFY MATLAB code for mas_classify.fig
%      MAS_CLASSIFY, by itself, creates a new MAS_CLASSIFY or raises the existing
%      singleton*.
%
%      H = MAS_CLASSIFY returns the handle to a new MAS_CLASSIFY or the handle to
%      the existing singleton*.
%
%      MAS_CLASSIFY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAS_CLASSIFY.M with the given input arguments.
%
%      MAS_CLASSIFY('Property','Value',...) creates a new MAS_CLASSIFY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mas_classify_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mas_classify_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mas_classify

% Last Modified by GUIDE v2.5 09-Sep-2018 22:13:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mas_classify_OpeningFcn, ...
                   'gui_OutputFcn',  @mas_classify_OutputFcn, ...
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


% --- Executes just before mas_classify is made visible.
function mas_classify_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no out args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mas_classify (see VARARGIN)

% Choose default command line out for mas_classify
handles.out = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mas_classify wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mas_classify_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning out args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line out from handles structure
varargout{1} = handles.out;


% --- Executes on button press in load training data.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global training_data;
training_data='E:\Fourth Year\4-2\Data Warehousing and Mining\LAB\LAB_2b\Database.xlsx';


% --- Executes on button press in query data load.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 global query_data;
 query_data=input('input query data(22) : ');




% --- Executes on button press in proximity calculation.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global query_data;
global training_data;
global count;
count=0;
global class;

global proximitymatrix;
proximitymatrix=double(8124);

%[~,train_cell]=xlsread(training_data, strcat('A', num2str(i),':','W', num2str(i)));
    [~,train_cell]=xlsread(training_data,'A1:W8000');
    train_mat=cell2mat(train_cell);
    
    for i=1:8000
        for j=2:23
            if query_data(j-1)==train_mat(i,j)
                count=count+1;
            end
        end
        
        proximity=(22-count)/22;
        proximitymatrix(i)=proximity;
        class=train_mat(:,1);
        count=0;
    end
    newMatrix= proximitymatrix;
    
     



% --- Executes on button press in  textbox.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global proximitymatrix;
global class;

new_proMatrix=proximitymatrix(:);
[val, index]=min(new_proMatrix); %calculate minimum
fprintf('data proximity is : %f\n',val);
classify_result=class(index);
set(handles.text3, 'string',classify_result);
