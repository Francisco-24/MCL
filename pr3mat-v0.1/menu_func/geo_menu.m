function varargout = geo_menu(varargin)
% GEO_MENU MATLAB code for geo_menu.fig
%      GEO_MENU, by itself, creates a new GEO_MENU or raises the existing
%      singleton*.
%
%      H = GEO_MENU returns the handle to a new GEO_MENU or the handle to
%      the existing singleton*.
%
%      GEO_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GEO_MENU.M with the given input arguments.
%
%      GEO_MENU('Property','Value',...) creates a new GEO_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before geo_menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to geo_menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help geo_menu

% Last Modified by GUIDE v2.5 24-Sep-2018 15:44:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @geo_menu_OpeningFcn, ...
                   'gui_OutputFcn',  @geo_menu_OutputFcn, ...
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

end
% --- Executes just before geo_menu is made visible.
function geo_menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to geo_menu (see VARARGIN)

% Choose default command line output for geo_menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes geo_menu wait for user response (see UIRESUME)
uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = geo_menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

end

% --- Executes on selection change in geo_menu.
function geo_menu_Callback(hObject, eventdata, handles)
% hObject    handle to geo_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns geo_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from geo_menu

global geometry

geo = (get(handles.geo_menu, 'Value'));


if (geo >= 14)
    
    geo = geo + 2;
end

if (geo == 1)
    
    geometry = 212;
    

elseif (geo == 20)
    
    geometry = 213;
    
elseif (geo == 30)
    
    geometry = 70;
    
elseif (geo == 39)
    
    geometry = 201; 
    
elseif (geo == 49)
    
    geometry = 301;
    
else
    
    geometry = geo;
end

geo_img = sprintf('geo%d.jpg', geometry);
imshow(geo_img);


end

% --- Executes during object creation, after setting all properties.
function geo_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to geo_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in cont_button.
function cont_button_Callback(hObject, eventdata, handles)
% hObject    handle to cont_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cont_button
global geometry

geo = (get(handles.geo_menu, 'Value'));

if (geo >= 14)
    
    geo = geo + 2;
end

if (geo == 1)
    
    geometry = 212;
    

elseif (geo == 20)
    
    geometry = 213;
    
elseif (geo == 30)
    
    geometry = 70;
    
elseif (geo == 39)
    
    geometry = 201; 
    
elseif (geo == 49)
    
    geometry = 301;
    
else
    
    geometry = geo;
end

fid = fopen('prhinput.txt', 'w');

if fid == -1
       clc
       fprintf('Error opening file.');
end

fprintf(fid, '%d\n%s\n%5d\n%5d\n', 1,'HOMO', 7, geometry);
fc = fclose(fid);

if fc == -1
       clc
       fprintf('Error closing file.');
end

delete(handles.figure1);

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
end


% --- Executes during object creation, after setting all properties.
function geo_disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to geo_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate geo_disp
imshow('geo212.jpg');

end
