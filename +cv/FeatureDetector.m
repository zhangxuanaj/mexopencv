classdef FeatureDetector < handle
    %FEATUREDETECTOR  FeatureDetector class
    %
    % Feature detector class. Here is how to use:
    %
    %    detector = cv.FeatureDetector('SURF');
    %    keypoints = detector.detect(im);
    %
    % The following detector types are supported:
    %
    %     'FAST'       FastFeatureDetector
    %     'STAR'       StarFeatureDetector
    %     'SIFT'       SiftFeatureDetector
    %     'SURF'       SurfFeatureDetector
    %     'ORB'        OrbFeatureDetector
    %     'MSER'       MserFeatureDetector
    %     'GFTT'       GoodFeaturesToTrackDetector
    %     'HARRIS'     GoodFeaturesToTrackDetector with Harris detector enabled
    %     'Dense'      DenseFeatureDetector
    %     'SimpleBlob' SimpleBlobDetector
    %
    % Also a combined format with one of the following adaptor is
    % supported
    %
    %     'Grid'       GridAdaptedFeatureDetector
    %     'Pyramid'    PyramidAdaptedFeatureDetector
    %
    % for example: 'GridFAST', 'PyramidSTAR'.
    %
    % See also cv.FeatureDetector.FeatureDetector cv.FeatureDetector.write
    % cv.DescriptorExtractor
    %

    properties (SetAccess = private)
        % Object ID
        id
    end

    properties (SetAccess = private, Dependent)
        % Type of the detector
        type
    end

    properties (SetAccess = private, Hidden)
        % Keep track of the type of the detector used in constructor
        type_
    end

    methods
        function this = FeatureDetector(type)
            %FEATUREDETECTOR  FeatureDetector constructors
            %
            %    detector = cv.FeatureDetector(type)
            %
            % ## Input
            % * __type__ Type of the detector. see below. default 'FAST'
            %
            % ## Output
            % * __detector__ New instance of the FeatureDetector
            %
            % The following detector types are supported:
            %
            %     'FAST'       FastFeatureDetector
            %     'STAR'       StarFeatureDetector
            %     'SIFT'       SiftFeatureDetector
            %     'SURF'       SurfFeatureDetector
            %     'ORB'        OrbFeatureDetector
            %     'MSER'       MserFeatureDetector
            %     'GFTT'       GoodFeaturesToTrackDetector
            %     'HARRIS'     GoodFeaturesToTrackDetector with Harris detector enabled
            %     'Dense'      DenseFeatureDetector
            %     'SimpleBlob' SimpleBlobDetector
            %
            % Also a combined format with one of the following adaptor is
            % supported
            %
            %     'Grid'       GridAdaptedFeatureDetector
            %     'Pyramid'    PyramidAdaptedFeatureDetector
            %
            % for example: 'GridFAST', 'PyramidSTAR'.
            %
            % See also cv.FeatureDetector cv.FeatureDetector.write
            %
            if nargin < 1, type = 'FAST'; end
            if ~ischar(type)
                error('DescriptorExtractor:error','Invalid type');
            end
            this.id = FeatureDetector_(type);
            this.type_ = type;
        end

        function delete(this)
            %DELETE  FeatureDetector destructor
            %
            % See also cv.FeatureDetector
            %
            FeatureDetector_(this.id, 'delete');
        end

        function t = get.type(this)
            %TYPE  FeatureDetector type
            t = FeatureDetector_(this.id, 'type');
        end

        function keypoints = detect(this, im)
            %DETECT  Detects keypoints in an image
            %
            %    keypoints = detector.detect(im)
            %
            % ## Input
            % * __im__ Image
            %
            % ## Output
            % * __keypoints__ The detected keypoints
            %
            % See also cv.FeatureDetector
            %
            keypoints = FeatureDetector_(this.id, 'detect', im);
        end

        function read(this, filename)
            %READ  Reads a feature detector object from a file
            %
            %    detector.read(filename)
            %
            % ## Input
            % * __filename__ name of the xml/yaml file
            %
            % See also cv.FeatureDetector
            %
            FeatureDetector_(this.id, 'read', filename);
        end

        function write(this, filename)
            %WRITE  Writes a feature detector object to a file
            %
            %    detector.write(filename)
            %
            % ## Input
            % * __filename__ name of the xml/yaml file
            %
            % See also cv.FeatureDetector
            %
            FeatureDetector_(this.id, 'write', filename);
        end

        function str = name(this)
            %NAME  FeatureDetector name
            %
            %    str = detector.name()
            %
            % ## Output
            % *__str__ name of the detector
            %
            % See also cv.FeatureDetector
            %

            % avoid segmentation violation in MEX-file
            if strcmp(this.type_,'SimpleBlob') || strncmp(this.type_,'Pyramid',7)
                error('mexopencv:error', 'Detector currently not supported (OpenCV bug)');
            end

            str = FeatureDetector_(this.id, 'name');
        end

        function val = get(this, param)
            %GET  Get a feature detector parameter
            %
            %    val = detector.get('param_name')
            %    params = detector.get()
            %
            % ## Input
            % * __param__ parameter name as string
            %
            % See also cv.FeatureDetector.set
            %

            % avoid segmentation violation in MEX-file
            if strcmp(this.type_,'SimpleBlob') || strncmp(this.type_,'Pyramid',7)
                error('mexopencv:error', 'Detector currently not supported (OpenCV bug)');
            end

            if nargin < 2
                % return a struct of all params/values
                val = FeatureDetector_(this.id, 'get');
            else
                % get paramter
                val = FeatureDetector_(this.id, 'get', param);
            end
        end

        function set(this, param, value)
            %SET  Set a feature detector parameter
            %
            %    detector.set('param_name', value)
            %    detector.set()
            %
            % ## Input
            % * __param__ parameter name as string
            % * __value__ parameter value
            %
            % See also cv.FeatureDetector.get
            %

            % avoid segmentation violation in MEX-file
            if strcmp(this.type_,'SimpleBlob') || strncmp(this.type_,'Pyramid',7)
                error('mexopencv:error', 'Detector currently not supported (OpenCV bug)');
            end

            if nargin < 2
                % show list of all parameter names
                names = FeatureDetector_(this.id, 'set');
                disp(names(:))
            else
                % set parameter
                FeatureDetector_(this.id, 'set', param, value);
            end
        end
    end

end
