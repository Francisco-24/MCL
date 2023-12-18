function varargout = mat_prop70(varargin)
% MAT_PROP70 MATLAB code for mat_prop70.fig
%      MAT_PROP70, by itself, creates a new MAT_PROP70 or raises the existing
%      singleton*.
%
%      H = MAT_PROP70 returns the handle to a new MAT_PROP70 or the handle to
%      the existing singleton*.
%
%      MAT_PROP70('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAT_PROP70.M with the given input arguments.
%
%      MAT_PROP70('Property','Value',...) creates a new MAT_PROP70 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mat_prop70_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mat_prop70_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mat_prop70

% Last Modified by GUIDE v2.5 24-Sep-2018 14:38:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mat_prop70_OpeningFcn, ...
                   'gui_OutputFcn',  @mat_prop70_OutputFcn, ...
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


% --- Executes just before mat_prop70 is made visible.
function mat_prop70_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mat_prop70 (see VARARGIN)

% Choose default command line output for mat_prop70
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mat_prop70 wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mat_prop70_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure


% --- Executes on button press in compute.
function compute_Callback(hObject, eventdata, handles)
% hObject    handle to compute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
yung1 = str2double(get(handles.yung1, 'string'));
poisson1 = str2double(get(handles.poisson1, 'string'));
thermo_elas1 = str2double(get(handles.thermo_elas1, 'string'));
yung2 = str2double(get(handles.yung2, 'string'));
poisson2 = str2double(get(handles.poisson2, 'string'));
thermo_elas2 = str2double(get(handles.thermo_elas2, 'string'));
yung3 = str2double(get(handles.yung3, 'string'));
poisson3 = str2double(get(handles.poisson3, 'string'));
thermo_elas3 = str2double(get(handles.thermo_elas3, 'string'));
mesh = str2num(get(handles.mesh, 'string'));
dim_a1 = str2double(get(handles.dim_a1, 'string'));
dim_a2 = str2double(get(handles.dim_a2, 'string'));
dim_a3 = str2double(get(handles.dim_a3, 'string'));
dim_b1 = str2double(get(handles.dim_b1, 'string'));
dim_b2 = str2double(get(handles.dim_b2, 'string'));
dim_b3 = str2double(get(handles.dim_b3, 'string'));
dim_c1 = str2double(get(handles.dim_c1, 'string'));
dim_c2 = str2double(get(handles.dim_c2, 'string'));
dim_c3 = str2double(get(handles.dim_c3, 'string'));
theta1 = str2double(get(handles.theta1, 'string'));
theta2 = str2double(get(handles.theta2, 'string'));
theta3 = str2double(get(handles.theta3, 'string'));
solver_opt = get(handles.solver, 'Value');
nodes_opt = get(handles.nodes, 'Value');

switch nodes_opt
    case 1
        nodes = 4;
    case 2
        nodes = 8;
    case 3
        nodes = 10;
    case 4
        nodes = 20;
end

if solver_opt == 1
    solver = 0;
else
    solver = 1;
end

fid = fopen('prhinput.txt', 'a');

if fid == -1
       clc
       fprintf('Error opening file.');
end

fprintf(fid, '%10.2e%10.2e%10.2e\n', yung1, poisson1, thermo_elas1 );
fprintf(fid, '%10.2e%10.2e%10.2e\n', yung2, poisson2, thermo_elas2 );
fprintf(fid, '%10.2e%10.2e%10.2e\n', yung3, poisson3, thermo_elas3 );
fprintf(fid, '%5d%5d%5d\n',mesh, nodes, solver);
fprintf(fid, '%10.2e%10.2e%10.2e\n', dim_a1, dim_a2, dim_a3);
fprintf(fid, '%10.2e%10.2e%10.2e\n', dim_b1, dim_b2, dim_b3);
fprintf(fid, '%10.2e%10.2e%10.2e\n', dim_c1, dim_c2, dim_c3);
fprintf(fid, '%10.2e%10.2e%10.2e\n', theta1, theta2, theta3');
fc = fclose(fid);

if fc == -1
       clc
       fprintf('Error closing file.');
end

global cont
cont = 1;
delete(handles.figure1);

% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cont
cont = 0;
delete(handles.figure1);

% --- Executes on selection change in axis.
function axis_Callback(hObject, eventdata, handles)
% hObject    handle to axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns axis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from axis


% --- Executes during object creation, after setting all properties.
function axis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta1_Callback(hObject, eventdata, handles)
% hObject    handle to theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta1 as text
%        str2double(get(hObject,'String')) returns contents of theta1 as a double


% --- Executes during object creation, after setting all properties.
function theta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta2_Callback(hObject, eventdata, handles)
% hObject    handle to theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta2 as text
%        str2double(get(hObject,'String')) returns contents of theta2 as a double


% --- Executes during object creation, after setting all properties.
function theta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta3_Callback(hObject, eventdata, handles)
% hObject    handle to theta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta3 as text
%        str2double(get(hObject,'String')) returns contents of theta3 as a double


% --- Executes during object creation, after setting all properties.
function theta3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yung_Callback(hObject, eventdata, handles)
% hObject    handle to yung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yung as text
%        str2double(get(hObject,'String')) returns contents of yung as a double


% --- Executes during object creation, after setting all properties.
function yung_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thermo_elas_Callback(hObject, eventdata, handles)
% hObject    handle to thermo_elas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thermo_elas as text
%        str2double(get(hObject,'String')) returns contents of thermo_elas as a double


% --- Executes during object creation, after setting all properties.
function thermo_elas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thermo_elas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function poisson_Callback(hObject, eventdata, handles)
% hObject    handle to poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of poisson as text
%        str2double(get(hObject,'String')) returns contents of poisson as a double


% --- Executes during object creation, after setting all properties.
function poisson_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fyung_Callback(hObject, eventdata, handles)
% hObject    handle to fyung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fyung as text
%        str2double(get(hObject,'String')) returns contents of fyung as a double


% --- Executes during object creation, after setting all properties.
function fyung_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fyung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fthermo_elas_Callback(hObject, eventdata, handles)
% hObject    handle to fthermo_elas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fthermo_elas as text
%        str2double(get(hObject,'String')) returns contents of fthermo_elas as a double


% --- Executes during object creation, after setting all properties.
function fthermo_elas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fthermo_elas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eli_exp_Callback(hObject, eventdata, handles)
% hObject    handle to eli_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eli_exp as text
%        str2double(get(hObject,'String')) returns contents of eli_exp as a double


% --- Executes during object creation, after setting all properties.
function eli_exp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eli_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fpoisson_Callback(hObject, eventdata, handles)
% hObject    handle to fpoisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fpoisson as text
%        str2double(get(hObject,'String')) returns contents of fpoisson as a double


% --- Executes during object creation, after setting all properties.
function fpoisson_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fpoisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dim_a2_Callback(hObject, eventdata, handles)
% hObject    handle to dim_a2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dim_a2 as text
%        str2double(get(hObject,'String')) returns contents of dim_a2 as a double


% --- Executes during object creation, after setting all properties.
function dim_a2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dim_a2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dim_a3_Callback(hObject, eventdata, handles)
% hObject    handle to dim_a3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dim_a3 as text
%        str2double(get(hObject,'String')) returns contents of dim_a3 as a double


% --- Executes during object creation, after setting all properties.
function dim_a3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dim_a3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dim_a1_Callback(hObject, eventdata, handles)
% hObject    handle to dim_a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dim_a1 as text
%        str2double(get(hObject,'String')) returns contents of dim_a1 as a double


% --- Executes during object creation, after setting all properties.
function dim_a1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dim_a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in solver.
function solver_Callback(hObject, eventdata, handles)
% hObject    handle to solver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns solver contents as cell array
%        contents{get(hObject,'Value')} returns selected item from solver


% --- Executes during object creation, after setting all properties.
function solver_CreateFcn(hObject, eventdata, handles)
% hObject    handle to solver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mesh_Callback(hObject, eventdata, handles)
% hObject    handle to mesh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mesh as text
%        str2double(get(hObject,'String')) returns contents of mesh as a double


% --- Executes during object creation, after setting all properties.
function mesh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mesh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in nodes.
function nodes_Callback(hObject, eventdata, handles)
% hObject    handle to nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns nodes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from nodes


% --- Executes during object creation, after setting all properties.
function nodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function geo_disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to geo_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate geo_disp
global geometry
geo_img = sprintf('geo%d.jpg', geometry);
imshow(geo_img);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
global close
close = 1;
delete(hObject);



function yung3_Callback(hObject, eventdata, handles)
% hObject    handle to yung3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yung3 as text
%        str2double(get(hObject,'String')) returns contents of yung3 as a double


% --- Executes during object creation, after setting all properties.
function yung3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yung3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thermo_elas3_Callback(hObject, eventdata, handles)
% hObject    handle to thermo_elas3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thermo_elas3 as text
%        str2double(get(hObject,'String')) returns contents of thermo_elas3 as a double


% --- Executes during object creation, after setting all properties.
function thermo_elas3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thermo_elas3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function poisson3_Callback(hObject, eventdata, handles)
% hObject    handle to poisson3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of poisson3 as text
%        str2double(get(hObject,'String')) returns contents of poisson3 as a double


% --- Executes during object creation, after setting all properties.
function poisson3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poisson3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yung2_Callback(hObject, eventdata, handles)
% hObject    handle to yung2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yung2 as text
%        str2double(get(hObject,'String')) returns contents of yung2 as a double


% --- Executes during object creation, after setting all properties.
function yung2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yung2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thermo_elas2_Callback(hObject, eventdata, handles)
% hObject    handle to thermo_elas2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thermo_elas2 as text
%        str2double(get(hObject,'String')) returns contents of thermo_elas2 as a double


% --- Executes during object creation, after setting all properties.
function thermo_elas2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thermo_elas2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function poisson2_Callback(hObject, eventdata, handles)
% hObject    handle to poisson2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of poisson2 as text
%        str2double(get(hObject,'String')) returns contents of poisson2 as a double


% --- Executes during object creation, after setting all properties.
function poisson2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poisson2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dim_b1_Callback(hObject, eventdata, handles)
% hObject    handle to dim_b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dim_b1 as text
%        str2double(get(hObject,'String')) returns contents of dim_b1 as a double


% --- Executes during object creation, after setting all properties.
function dim_b1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dim_b1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dim_b2_Callback(hObject, eventdata, handles)
% hObject    handle to dim_b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dim_b2 as text
%        str2double(get(hObject,'String')) returns contents of dim_b2 as a double


% --- Executes during object creation, after setting all properties.
function dim_b2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dim_b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dim_b3_Callback(hObject, eventdata, handles)
% hObject    handle to dim_b3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dim_b3 as text
%        str2double(get(hObject,'String')) returns contents of dim_b3 as a double


% --- Executes during object creation, after setting all properties.
function dim_b3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dim_b3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dim_c1_Callback(hObject, eventdata, handles)
% hObject    handle to dim_c1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dim_c1 as text
%        str2double(get(hObject,'String')) returns contents of dim_c1 as a double


% --- Executes during object creation, after setting all properties.
function dim_c1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dim_c1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dim_c2_Callback(hObject, eventdata, handles)
% hObject    handle to dim_c2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dim_c2 as text
%        str2double(get(hObject,'String')) returns contents of dim_c2 as a double


% --- Executes during object creation, after setting all properties.
function dim_c2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dim_c2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dim_c3_Callback(hObject, eventdata, handles)
% hObject    handle to dim_c3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dim_c3 as text
%        str2double(get(hObject,'String')) returns contents of dim_c3 as a double


% --- Executes during object creation, after setting all properties.
function dim_c3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dim_c3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yung1_Callback(hObject, eventdata, handles)
% hObject    handle to yung1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yung1 as text
%        str2double(get(hObject,'String')) returns contents of yung1 as a double


% --- Executes during object creation, after setting all properties.
function yung1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yung1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thermo_elas1_Callback(hObject, eventdata, handles)
% hObject    handle to thermo_elas1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thermo_elas1 as text
%        str2double(get(hObject,'String')) returns contents of thermo_elas1 as a double


% --- Executes during object creation, after setting all properties.
function thermo_elas1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thermo_elas1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function poisson1_Callback(hObject, eventdata, handles)
% hObject    handle to poisson1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of poisson1 as text
%        str2double(get(hObject,'String')) returns contents of poisson1 as a double


% --- Executes during object creation, after setting all properties.
function poisson1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poisson1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
