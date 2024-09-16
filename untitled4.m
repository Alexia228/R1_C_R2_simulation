

Period = 3;

Timer = tic;

stop = false;
flag = 'off'
while ~stop

time = toc(Timer)

% if Vc > Vc_lim && flag == "off"
%     local_time = toc(Timer);
%     flag  = 'on';
% end

if time >= Period
    stop = true;
end
end















