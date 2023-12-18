function varargout = mat_prop4(varargin)
% MAT_PROP4 MATLAB code for mat_prop4.fig
%      MAT_PROP4, by itself, creates a new MAT_PROP4 or raises the existing
%      singleton*.
%
%      H = MAT_PROP4 returns the handle to a new MAT_PROP4 or the handle to
%      the existing singleton*.
%
%      MAT_PROP4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAT_PROP4.M with the given input arguments.
%
%      MAT_PROP4('Property','Value',...) creates a new MAT_PROP4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mat_prop4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mat_prop4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mat_prop4

% Last Modified by GUIDE v2.5 04-Sep-2018 16:53:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mat_prop4_OpeningFcn, ...
                   'gui_OutputFcn',  @mat_prop4_OutputFcn, ...
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


% --- Executes just before mat_prop4 is made visible.
function mat_prop4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mat_prop4 (see VARARGIN)

% Choose default command line output for mat_prop4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mat_prop4 wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mat_prop4_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure


% --- Executes during object creation, after setting all properties.
function geo_disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to geo_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate geo_disp
global geometry
geo_img = sprintf('geo%d.jpg', geometry);
imshow(geo_img);

% --- Executes on button press in compute.
function compute_Callback(hObject, eventdata, handles)
% hObject    handle to compute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
yung = str2double(get(handles.yung, 'string'));
poisson = str2double(get(handles.poisson, 'string'));
thermo_elas = str2double(get(handles.thermo_elas, 'string'));
mesh = str2num(get(handles.mesh, 'string'));
ratio_ab = str2double(get(handles.ratioab, 'string'));
ratio_ab1 = str2double(get(handles.ratioab1, 'string'));
density = str2double(get(handles.density, 'string'));
theta1 = str2double(get(handles.theta1, 'string'));
theta2 = str2double(get(handles.theta2, 'string'));
theta3 = str2double(get(handles.theta3, 'string'));
solver_opt = get(handles.solver, 'Value');
nodes_opt = get(handles.nodes, 'Value');
fpoisson = str2double(get(handles.fpoisson, 'string'));
fthermo_elas = str2double(get(handles.fthermo_elas, 'string'));
fyung = str2double(get(handles.fyung, 'string'));
eli_exp = str2double(get(handles.eli_exp, 'string'));
ratio_ac = str2double(get(handles.ratioac, 'string'));
ratio_ac1 = str2double(get(handles.ratioac1, 'string'));

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

fprintf(fid, '%10.2e%10.2e%10.2e\n', yung, poisson, thermo_elas );
fprintf(fid, '%10.2e%10.2e%10.2e\n', fyung, fpoisson, fthermo_elas);
fprintf(fid, '%5d%5d%5d%5d\n',eli_exp, mesh, nodes, solver);
fprintf(fid, '%10.2e%10.2e%10.2e%10.2e%10.2e\n', ratio_ab,ratio_ac, ratio_ab1,ratio_ac1, density);
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
guidata(hObject, handles);
delete(handles.figure1);


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



function ratioab_Callback(hObject, eventdata, handles)
% hObject    handle to ratioab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratioab as text
%        str2double(get(hObject,'String')) returns contents of ratioab as a double


% --- Executes during object creation, after setting all properties.
function ratioab_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratioab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratioac_Callback(hObject, eventdata, handles)
% hObject    handle to ratioac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratioac as text
%        str2double(get(hObject,'String')) returns contents of ratioac as a double


% --- Executes during object creation, after setting all properties.
function ratioac_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratioac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratioab1_Callback(hObject, eventdata, handles)
% hObject    handle to ratioab1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratioab1 as text
%        str2double(get(hObject,'String')) returns contents of ratioab1 as a double


% --- Executes during object creation, after setting all properties.
function ratioab1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratioab1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ratioac1_Callback(hObject, eventdata, handles)
% hObject    handle to ratioac1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ratioac1 as text
%        str2double(get(hObject,'String')) returns contents of ratioac1 as a double


% --- Executes during object creation, after setting all properties.
function ratioac1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ratioac1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function density_Callback(hObject, eventdata, handles)
% hObject    handle to density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of density as text
%        str2double(get(hObject,'String')) returns contents of density as a double


% --- Executes during object creation, after setting all properties.
function density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to density (see GCBO)
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


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
global close
close = 1;
delete(hObject);
