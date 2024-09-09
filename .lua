-- Anti-Vote Kick Script

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Function to handle vote kick prevention
local function onVoteKickRequest(voteKickRequest)
    -- Check if the player is the target of the vote kick
    if voteKickRequest.Target == player then
        -- Cancel the vote kick
        voteKickRequest:Destroy()
        print("Vote kick attempt against you has been canceled.")
    end
end

-- Connect the function to the VoteKickRequested event
Players.PlayerAdded:Connect(function(playerAdded)
    playerAdded.PlayerRemoving:Connect(function()
        -- Clean up any remaining vote kick requests for this player
        local voteKickRequests = game:GetService("ReplicatedStorage"):FindFirstChild("VoteKickRequests")
        if voteKickRequests then
            for _, request in pairs(voteKickRequests:GetChildren()) do
                if request.Target == playerAdded then
                    request:Destroy()
                end
            end
        end
    end)
end)

-- Listen for vote kick requests
local voteKickRequests = game:GetService("ReplicatedStorage"):FindFirstChild("VoteKickRequests")
if voteKickRequests then
    voteKickRequests.ChildAdded:Connect(onVoteKickRequest)
end
