//
//  Player.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 26.08.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import AVKit

class Player: NSObject {
    
    static var shared = Player()
    
    var avPlayer: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    var playerItem: AVPlayerItem? 
    
    private var urlCurrentTrack: String?
    
    func playTrack(previewUrl: String?) {
        if urlCurrentTrack != previewUrl {
            urlCurrentTrack = previewUrl
            guard let url = URL(string: previewUrl ?? "") else { return }
            playerItem = AVPlayerItem(url: url)
            avPlayer.replaceCurrentItem(with: playerItem)
            avPlayer.play()
        }
    }
    
    func handelCurrentTimerSlider(slider: UISlider) {
        let percentage = slider.value
        guard let duration = avPlayer.currentItem?.duration else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeInSeconds = Float64(percentage) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: 1)
        avPlayer.seek(to: seekTime)
    }
    
    func observePlayerCurrantTime(slider: UISlider, currentTimeLabel: UILabel, durationLabel: UILabel) {
        let interval = CMTime(value: 1, timescale: 2)
        avPlayer.addPeriodicTimeObserver(forInterval: interval, queue: nil, using: { [weak self] (time) in
            guard let self = self else { return }
            currentTimeLabel.text = time.toDisplayString()
            let durationTime = self.avPlayer.currentItem?.duration
            let currentDurationText = ((durationTime ?? CMTimeMake(value: 1, timescale: 1)) - time).toDisplayString()
            durationLabel.text = "-\(currentDurationText)"
            self.updateCurrentTimeSlider(slider: slider)
        })
    }
    
    private func updateCurrentTimeSlider(slider: UISlider) {
        let currentTimeSeconds = CMTimeGetSeconds(avPlayer.currentTime())
        let durationSeconds = CMTimeGetSeconds(avPlayer.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage = currentTimeSeconds / durationSeconds
        slider.value = Float(percentage)
    }
}
