function Xhat = decode_beamformer(cfg0, decoder, Y)
% [Xhat] = decode_beamformer(cfg, decoder, Y)
%    Estimate the activity of latent components using a linear decoder, obtained from an
%    appropriate training function. Several components may be estimated independently.
%
%    decoder     The linear decoder obtained from e.g. train_beamformer.
%    Y           Matrix of size F x N, where F is the number of features and the N the number of trials,
%                that contains the data that is to be decoded.
%    cfg         Configuration struct that can possess the following fields:
%                .demean = 'yes' or 'no'          Whether the data should be demeaned (per feature,
%                                                 over trials) prior to decoding, based on the mean
%                                                 of the training data. Only available when .demean
%                                                 was 'yes' during training. Default = 'yes';
%
%    Xhat        Vector or matrix of size C x N, where C is the number of components, containing
%                the decoded data.
%
%    See also TRAIN_BEAMFORMER.

%    Created by Pim Mostert, 2016

if ~isfield(cfg0, 'demean')
    cfg0.demean = 'yes';
end

% Convert to matrix
numN = size(Y, 2);
numF = size(Y, 1);

% Demean
if strcmp(cfg0.demean, 'yes') && isfield(decoder, 'mY')
    Y = Y - repmat(decoder.mY, [1, numN]);
end

% Decode
Xhat = decoder.W*Y;

end
