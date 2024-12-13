function varargout = test2(varargin)
% TEST2 MATLAB code for test2.fig
%      TEST2, by itself, creates a new TEST2 or raises the existing
%      singleton*.
%
%      H = TEST2 returns the handle to a new TEST2 or the handle to
%      the existing singleton*.
%
%      TEST2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST2.M with the given input arguments.
%
%      TEST2('Property','Value',...) creates a new TEST2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test2

% Last Modified by GUIDE v2.5 13-Dec-2024 19:17:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test2_OpeningFcn, ...
                   'gui_OutputFcn',  @test2_OutputFcn, ...
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


% --- Executes just before test2 is made visible.
function test2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test2 (see VARARGIN)

% Choose default command line output for test2
handles.output = hObject;

% Initialize global variables
global img;
img = []; % Initialize as empty

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
global img;
global gray;
global noisy;
 % Check if an image is loaded
    if isempty(img)
        msgbox('No image loaded. Please upload an image first.', 'Error', 'error');
        return;
    end
axes(handles.axes5);
cla; 
 set(handles.axes5, 'Visible', 'off');
 axes(handles.axes3);
cla; 
 set(handles.axes3, 'Visible', 'off');

    % Get the selected value from the popup menu
    contents = cellstr(get(hObject, 'String')); % All options in the menu
    select = contents{get(hObject, 'Value')}; % Selected option
   % Perform an action based on the selected option
    switch select
        case 'Histogram Equalization'
        if size(img, 3) == 3
            % Image is RGB
            disp('The image is RGB.');
            % rgb equalization
            eq = img;
            eq(:,:,1) = histeq(img(:,:,1));
            eq(:,:,2) = histeq(img(:,:,2));
            eq(:,:,3) = histeq(img(:,:,3));
            axes(handles.axes4);
            imshow(eq);
            title('Equalized Image');
        else
            % Image is grayscale
            disp('The image is grayscale.');
            % gray equalization
            eq = histeq(img);
            axes(handles.axes4);
            imshow(eq);
            title('Equalized Image');
        end

       case 'Histogram Stretching'
            % histogram stretching 
            low_in = str2double(get(handles.edit1, 'string'));
            high_in = str2double(get(handles.edit2, 'string'));
            % Validate inputs
            if isnan(low_in) || isnan(high_in) || low_in < 0 || high_in > 255 || low_in >= high_in
                msgbox('Invalid input for Low and High values. Please provide valid values.', 'Error', 'error');
                return;
            end
            stretch = imadjust(img ,[low_in/255 high_in/255], []);
            axes(handles.axes4);
            imshow(stretch);
            title('Stretched Image');

        case 'Median'
            if size(img, 3) == 3
                gray = img(:,:,1)*0.2989+img(:,:,2)*0.5870+img(:,:,3)*0.1140;
            else
                gray = img;
            end
            noisy = imnoise(gray,'salt & pepper', 0.2);
            set(handles.axes5, 'Visible', 'on');  
            axes(handles.axes5);
            imshow(noisy);
            med = medgray(noisy);
            axes(handles.axes4);
            imshow(med);
            title('Median filter');

        case 'Neighbourhood Average'
                image = img;
                averaged = neighborhood_average_filter(image);
                axes(handles.axes4);
                imshow(averaged);
                title('Averaged Image');
             
        case 'Sobel'
            sobel = sobel_detector(img);
            axes(handles.axes4);
            imshow(sobel);
            title('Sobel Edge-detection');
            
        case 'Low-Pass(Gaussian)'
            if size(img, 3) == 1
                % Grayscale Image
                isGray = true;
            else
                % RGB Image
                isGray = false;
            end

            % Apply Low-Pass Filtering (Gaussian)
            sigma = 1.0; % Standard deviation
            if isGray
                % Grayscale case
                lowPassFiltered = imgaussfilt(img, sigma);
            else
                % RGB case
                lowPassFiltered = imgaussfilt(img, sigma);
            end
            axes(handles.axes4);
            imshow(uint8(lowPassFiltered));
            title('Gaussian Image');
            
            
        case 'High-Pass(Laplaician)'
            laplacian = laplacianfilter(img);
            axes(handles.axes4);
            imshow(laplacian);
            title('Laplacian Image');
            
        case 'Convert to Gray'
            if size(img, 3) == 3
            set(handles.axes3, 'Visible', 'on');
                gray = img(:,:,1)*0.2989+img(:,:,2)*0.5870+img(:,:,3)*0.1140;
                axes(handles.axes3);
                imshow(gray);
            else 
                msgbox('Image is already Gray')
            end

        otherwise
            msgbox('Invalid selection');
    end


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Upload image
global img;
    axes(handles.axes2);%histogram axes
        cla; 
    axes(handles.axes3);%gray axes
        cla;
        set(handles.pushbutton3, 'Visible', 'off');
    axes(handles.axes4);%output axes
        cla; 
        set(handles.axes4, 'Visible', 'on');
    axes(handles.axes5);%noise axes
        cla; 
        set(handles.axes5, 'Visible', 'off');
        
[fileName, path]= uigetfile({'*.jpg;*.png;*.gif;*.tif;*.bmp*','Image Files'},'Select an image');
if fileName ~= 0 
    img= imread(fullfile(path, fileName));
    axes(handles.axes1);
imshow(img);
title('Original Image');
else
    disp('operation cancelled');
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% gray histogram
global img
global gray;
if size(img, 3) == 3
        % The image is RGB
        disp('RGB image detected');
        hist = imhist(gray);
        axes(handles.axes2);
        plot(hist , 'black');

    else
        % The image is already grayscale
        disp('Grayscale image detected. No additional axes or button required.');
        gray = img;
        hist = imhist(gray);
        axes(handles.axes2);
        plot(hist , 'black');
end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
