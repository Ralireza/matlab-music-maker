function varargout = audio_player(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @audio_player_OpeningFcn, ...
                   'gui_OutputFcn',  @audio_player_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before audio_player is made visible.
function audio_player_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for audio_player
handles.output = hObject;

[y, Fs] = audioread('./bird.wav');
handles.length = length(y);
handles.player = audioplayer(y, Fs);
handles.next_position = -1;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = audio_player_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function audio_slider_Callback(hObject, eventdata, handles)
% hObject    handle to audio_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
playerinfo = get(handles.player);
position = playerinfo.TotalSamples * get(hObject, 'Value');

if strcmp(get(handles.player, 'Running'), 'on')
    stop(handles.player);
    play(handles.player, round(position));
else
    handles.next_position = round(position);
    guidata(hObject, handles);
end


% --- Executes during object creation, after setting all properties.
function audio_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to audio_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
% hObject    handle to pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if strcmp(get(handles.player, 'Running'), 'on')
    pause(handles.player);
end


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if strcmp(get(handles.player, 'Running'), 'off')
    if handles.next_position >= 0
        play(handles.player, handles.next_position);

        handles.next_position = -1;
        guidata(hObject, handles);
    else
        resume(handles.player);
    end
        
    while strcmp(get(handles.player, 'Running'), 'on')
        playerinfo = get(handles.player);
        position = playerinfo.CurrentSample / playerinfo.TotalSamples;
        set(handles.audio_slider, 'Value', position);

        pause(0.5);
    end
end
