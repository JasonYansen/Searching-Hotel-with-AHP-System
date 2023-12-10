function varargout = Final_Project(varargin)
% FINAL_PROJECT MATLAB code for Final_Project.fig
%      FINAL_PROJECT, by itself, creates a new FINAL_PROJECT or raises the existing
%      singleton*.
%
%      H = FINAL_PROJECT returns the handle to a new FINAL_PROJECT or the handle to
%      the existing singleton*.
%
%      FINAL_PROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINAL_PROJECT.M with the given input arguments.
%
%      FINAL_PROJECT('Property','Value',...) creates a new FINAL_PROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Final_Project_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Final_Project_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Final_Project

% Last Modified by GUIDE v2.5 22-May-2023 08:53:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Final_Project_OpeningFcn, ...
                   'gui_OutputFcn',  @Final_Project_OutputFcn, ...
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


% --- Executes just before Final_Project is made visible.
function Final_Project_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Final_Project (see VARARGIN)

% Choose default command line output for Final_Project
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Final_Project wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Final_Project_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnHitung.
function btnHitung_Callback(hObject, eventdata, handles)
% hObject    handle to btnHitung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NH1 = get(handles.txNHotel1,'string');
NH2 = get(handles.txNHotel2,'string');
NH3 = get(handles.txNHotel3,'string');
NH4 = get(handles.txNHotel4,'string');

FH1 = str2double(get(handles.txFH1,'string'));
FH2 = str2double(get(handles.txFH2,'string'));
FH3 = str2double(get(handles.txFH3,'string'));
FH4 = str2double(get(handles.txFH3,'string'));
J1 = str2double(get(handles.txJ1,'string'));
J2 = str2double(get(handles.txJ2,'string'));
J3 = str2double(get(handles.txJ4,'string'));
J4 = str2double(get(handles.txJ4,'string'));
H1 = str2double(get(handles.txH1,'string'));
H2 = str2double(get(handles.txH2,'string'));
H3 = str2double(get(handles.txH4,'string'));
H4 = str2double(get(handles.txH4,'string'));
data = [FH1 J1 H1
        FH2 J2 H2
        FH3 J3 H3
        FH4 J4 H4];
maksFH = 10;
maksJ = 10;
maksH = 10;

data(:,1) = data(:,1)/maksFH;
data(:,2) = data(:,2)/maksJ;
data(:,3) = data(:,3)/maksH;

relasiAntarKriteria = [1 2 2
                       0 1 4
                       0 0 1];
   
TFN = { [-100/3 0 100/3] [3/100 0 -3/100]
        [0 100/3 200/3] [3/200 3/100 0 ]
        [100/3 200/3 300/3] [3/300 3/200 3/100 ]
        [200/3 300/3 400/3] [3/400 3/300 3/200 ]};
           
[RasioKonsistensi] = HitungKonsistensiAHP(relasiAntarKriteria)

if RasioKonsistensi < 0.10
    [bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP(relasiAntarKriteria, TFN);
    ahp = data * bobotAntarKriteria';
for i = 1:size(ahp, 1)
        if ahp(i) < 0.6
            status = 'Kurang';
        elseif ahp(i) < 0.7
            status = 'Cukup';
        elseif ahp(i) < 0.8
            status = 'Baik';
        else
            status = 'Sangat Baik';
        end
        skor(i)= ahp(i);
        if i == 1
            set(handles.Req_Hotel1,'string',(status));
        elseif i == 2
            set(handles.Req_Hotel2,'string',(status));
        elseif i == 3
            set(handles.Req_Hotel3,'string',(status));
        elseif i == 4
            set(handles.Req_Hotel4,'string',(status));
        end
end

set(handles.Hotel1,'string',NH1);
set(handles.Hotel2,'string',NH2);
set(handles.Hotel3,'string',NH3);
set(handles.Hotel4,'string',NH4);

set(handles.Hasil_Hotel1,'string',(skor(1)));
set(handles.Hasil_Hotel2,'string',(skor(2)));
set(handles.Hasil_Hotel3,'string',(skor(3)));
set(handles.Hasil_Hotel4,'string',(skor(4)));
end
        
% --- Executes during object creation, after setting all properties.
function Hotel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Hotel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function txNHotel1_Callback(hObject, eventdata, handles)
% hObject    handle to txNHotel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txNHotel1 as text
%        str2double(get(hObject,'String')) returns contents of txNHotel1 as a double


% --- Executes during object creation, after setting all properties.
function txNHotel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txNHotel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txNHotel2_Callback(hObject, eventdata, handles)
% hObject    handle to txNHotel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txNHotel2 as text
%        str2double(get(hObject,'String')) returns contents of txNHotel2 as a double


% --- Executes during object creation, after setting all properties.
function txNHotel2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txNHotel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txNHotel3_Callback(hObject, eventdata, handles)
% hObject    handle to txNHotel3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txNHotel3 as text
%        str2double(get(hObject,'String')) returns contents of txNHotel3 as a double


% --- Executes during object creation, after setting all properties.
function txNHotel3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txNHotel3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txNHotel4_Callback(hObject, eventdata, handles)
% hObject    handle to txNHotel4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txNHotel4 as text
%        str2double(get(hObject,'String')) returns contents of txNHotel4 as a double


% --- Executes during object creation, after setting all properties.
function txNHotel4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txNHotel4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txFH1_Callback(hObject, eventdata, handles)
% hObject    handle to txFH1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txFH1 as text
%        str2double(get(hObject,'String')) returns contents of txFH1 as a double


% --- Executes during object creation, after setting all properties.
function txFH1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txFH1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txFH2_Callback(hObject, eventdata, handles)
% hObject    handle to txFH2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txFH2 as text
%        str2double(get(hObject,'String')) returns contents of txFH2 as a double


% --- Executes during object creation, after setting all properties.
function txFH2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txFH2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txFH3_Callback(hObject, eventdata, handles)
% hObject    handle to txFH3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txFH3 as text
%        str2double(get(hObject,'String')) returns contents of txFH3 as a double


% --- Executes during object creation, after setting all properties.
function txFH3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txFH3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txFH4_Callback(hObject, eventdata, handles)
% hObject    handle to txFH3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txFH3 as text
%        str2double(get(hObject,'String')) returns contents of txFH3 as a double


% --- Executes during object creation, after setting all properties.
function txFH4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txFH3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txFK1_Callback(hObject, eventdata, handles)
% hObject    handle to txFK1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txFK1 as text
%        str2double(get(hObject,'String')) returns contents of txFK1 as a double


% --- Executes during object creation, after setting all properties.
function txFK1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txFK1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txFK2_Callback(hObject, eventdata, handles)
% hObject    handle to txFK2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txFK2 as text
%        str2double(get(hObject,'String')) returns contents of txFK2 as a double


% --- Executes during object creation, after setting all properties.
function txFK2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txFK2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txFK3_Callback(hObject, eventdata, handles)
% hObject    handle to txFK3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txFK3 as text
%        str2double(get(hObject,'String')) returns contents of txFK3 as a double


% --- Executes during object creation, after setting all properties.
function txFK3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txFK3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txFK4_Callback(hObject, eventdata, handles)
% hObject    handle to txFK4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txFK4 as text
%        str2double(get(hObject,'String')) returns contents of txFK4 as a double


% --- Executes during object creation, after setting all properties.
function txFK4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txFK4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txJ1_Callback(hObject, eventdata, handles)
% hObject    handle to txJ1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txJ1 as text
%        str2double(get(hObject,'String')) returns contents of txJ1 as a double


% --- Executes during object creation, after setting all properties.
function txJ1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txJ1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txJ2_Callback(hObject, eventdata, handles)
% hObject    handle to txJ2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txJ2 as text
%        str2double(get(hObject,'String')) returns contents of txJ2 as a double


% --- Executes during object creation, after setting all properties.
function txJ2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txJ2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txJ3_Callback(~, eventdata, handles)
% hObject    handle to txJ4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txJ4 as text
%        str2double(get(hObject,'String')) returns contents of txJ4 as a double


% --- Executes during object creation, after setting all properties.
function txJ3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txJ4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txJ4_Callback(hObject, eventdata, handles)
% hObject    handle to txJ4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txJ4 as text
%        str2double(get(hObject,'String')) returns contents of txJ4 as a double


% --- Executes during object creation, after setting all properties.
function txJ4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txJ4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txH1_Callback(hObject, eventdata, handles)
% hObject    handle to txH1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txH1 as text
%        str2double(get(hObject,'String')) returns contents of txH1 as a double


% --- Executes during object creation, after setting all properties.
function txH1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txH1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txH2_Callback(hObject, eventdata, handles)
% hObject    handle to txH2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txH2 as text
%        str2double(get(hObject,'String')) returns contents of txH2 as a double


% --- Executes during object creation, after setting all properties.
function txH2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txH2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txH3_Callback(hObject, eventdata, handles)
% hObject    handle to txH4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txH4 as text
%        str2double(get(hObject,'String')) returns contents of txH4 as a double


% --- Executes during object creation, after setting all properties.
function txH3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txH4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txH4_Callback(hObject, eventdata, handles)
% hObject    handle to txH4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txH4 as text
%        str2double(get(hObject,'String')) returns contents of txH4 as a double


% --- Executes during object creation, after setting all properties.
function txH4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txH4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
