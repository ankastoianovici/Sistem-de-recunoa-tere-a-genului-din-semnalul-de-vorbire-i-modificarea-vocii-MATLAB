function [f0] = freq(x, fs)
    % Estimate the fundamental frequency (f0) of the input signal x.
    
    % Constants and parameters
    oneCast = 1;
    WindowLength = 2293;
    hopLength = 441;
    
    % Calculate the number of hops
    numHopsFinal = ceil((length(x) - WindowLength) / hopLength) + oneCast;
    
    % Frame the signal
    N = 2293;
    hopSize = 441;
    numHops = ceil((length(x) - N) / hopSize) + oneCast;
    y = frameSignal(x, N, hopSize, numHops);

    % Estimate f0 using the NCF function
    f0 = NCF(y);
    
    % Clip the estimated frequencies to the range [50, 400] Hz
    f0(f0 < 50) = 50;
    f0(f0 > 400) = 400;

    % Reshape f0 to the final number of hops
    f0 = reshape(f0, numHopsFinal, 1);
end

function f0 = NCF(y)
    % Estimate the fundamental frequency (f0) using the Normalized Cross-Correlation Function (NCF).

    % Frequency range for pitch estimation
    pitchRange = [50, 400];
    fs = 44100;

    % Compute the NCF
    edge = round(fs ./ fliplr(pitchRange));
    yRMS = computeRMS(y, edge);
    lag = computeNCF(y, edge);

    % Normalize by RMS values and extract candidates
    domain = [zeros(edge(1) - 1, size(lag, 2)); lag];
    locs = getCandidates(domain, edge);

    % Calculate f0 from the lag
    f0 = fs ./ locs;
end

function y = frameSignal(x, N, hopSize, numHops)
    % Frame the input signal x into overlapping frames.

    y = zeros(N, numHops);
    for hop = 1:numHops
        temp = x(1 + hopSize * (hop - 1):min(N + hopSize * (hop - 1), length(x)), 1);
        y(1:min(N, numel(temp)), hop) = temp;
    end
end

function locs = getCandidates(domain, edge)
    % Extract candidates based on the maximum values in the specified domain.

    numCol = size(domain, 2);
    locs = zeros(numCol, 1);

    % Extract a region of interest from the domain
    lower = edge(1);
    upper = edge(end);
    domain = domain(lower:upper, :);

    % Find the index of the maximum value in each column
    for c = 1:numCol
        [~, tempLoc] = max(domain(:, c));
        locs(c) = tempLoc;
    end

    % Adjust the indices to the original range
    locs = lower + locs - 1;
end

function yRMS = computeRMS(y, edge)
    % Compute Root Mean Square (RMS) values from the NCF matrix.

    r = cast(size(y, 1), 'like', y);
    mxl = min(edge(end), r - 1);
    m2 = 2 ^ nextpow2(2 * r - 1);
    c1 = real(ifft(abs(fft(y, m2, 1)).^2, [], 1)) ./ sqrt(m2);
    Rt = [c1(m2 - mxl + (1:mxl), :); c1(1:mxl + 1, :)];
    yRMS = sqrt(Rt(edge(end) + 1, :));
    yRMS = repmat(yRMS, size(Rt, 1), 1);
    yRMS = yRMS(1:size(Rt, 1), :);
end

function lag = computeNCF(y, edge)
    % Compute the Normalized Cross-Correlation Function (NCF) for each frame.

    r = cast(size(y, 1), 'like', y);
    mxl = min(edge(end), r - 1);
    m2 = 2 ^ nextpow2(2 * r - 1);
    c1 = real(ifft(abs(fft(y, m2, 1)).^2, [], 1)) ./ sqrt(m2);
    lag = c1(m2 - mxl + (1:mxl), :);
end
