//
//  TrackDetailViewController.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 23.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit
import AVKit

class TrackDetailViewController: UIViewController {
    
    var presenter: TrackDetailPresenterProtocol?
    private var trackDetailView = TrackDetailView()
    var tracks: [TrackModel.Track]?
    var player = Player.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        loadAllView()
        creatButtonsActions()
        creatSlidersAction()
    }
    
    func loadAllView() {
        view.addSubview(trackDetailView)
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        trackDetailView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        trackDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
    }
    
//    func playTrack(previewUrl: String?) {
//        guard let url = URL(string: previewUrl ?? "") else { return }
//        let playerItem = AVPlayerItem(url: url)
//        player.replaceCurrentItem(with: playerItem)
//        player.play()
//
//    }
    
    //MARK: - ButtonsActions
    
    func creatButtonsActions() {
        trackDetailView.dragDownButton.addTarget(
            self,
            action: #selector(dragDownButtonPressed),
            for: .touchUpInside
        )
        
        trackDetailView.trackControlView.previousTrackButton.addTarget(
            self,
            action: #selector(previousTrackButtonPressed),
            for: .touchUpInside
        )
        
        trackDetailView.trackControlView.playPauseButton.addTarget(
            self,
            action: #selector(playPouseButtonPressed),
            for: .touchUpInside
        )
        
        trackDetailView.trackControlView.nextTrackButton.addTarget(
            self,
            action: #selector(nextTrackButtonPressed),
            for: .touchUpInside
        )
    }
    
    @objc func dragDownButtonPressed() {
        
        dismiss(animated: true, completion: nil)
        navigationController?.isNavigationBarHidden = false
        presenter?.popToRoot()
        
    }
    
    //MARK: - Track control buttons actions
    
    @objc func previousTrackButtonPressed() {
        presenter?.nextTrack(isNextTrack: false)
    }
    
    @objc func playPouseButtonPressed() {
        if player.avPlayer.timeControlStatus == .paused {
            player.avPlayer.play()
            trackDetailView.trackControlView.playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        } else {
            player.avPlayer.pause()
            trackDetailView.trackControlView.playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
    
    @objc func nextTrackButtonPressed() {
        presenter?.nextTrack(isNextTrack: true)
    }
    
    //MARK: - SlidersAction
    
    func creatSlidersAction() {
        
        trackDetailView.volumeSlider.addTarget(
            self,
            action: #selector(handleVolumeSlider),
            for: .allEvents
        )
        
        trackDetailView.currentTimeSlider.addTarget(
            self,
            action: #selector(handelCurrentTimerSlider),
            for: .allEvents
        )
    }
    
    @objc func handleVolumeSlider() {
        player.avPlayer.volume = trackDetailView.volumeSlider.value
    }
    
    @objc func handelCurrentTimerSlider() {
        let percentage = trackDetailView.currentTimeSlider.value
        guard let duration = player.avPlayer.currentItem?.duration else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeInSeconds = Float64(percentage) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: 1)
        player.avPlayer.seek(to: seekTime)
    }
    
}

extension TrackDetailViewController: TrackDetailViewProtocol {
    
    func setTrack(track: TrackModel.Track?) {
        trackDetailView.artistNameLabel.text = track?.artistName
        trackDetailView.trackNameLabel.text = track?.trackName
        let string600 = track?.iconUrlString?.replacingOccurrences(of: "100x100", with: "600x600")
        guard let url = URL(string: string600 ?? "") else { return }
        trackDetailView.trackImageView.sd_setImage(with: url)
        guard let previewUrl = track?.previewUrl else { return }
        player.playTrack(previewUrl: previewUrl)
        observePlayerCurrantTime()
        trackDetailView.trackControlView.playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
    }
    
    func observePlayerCurrantTime() {
        let interval = CMTime(value: 1, timescale: 2)
        player.avPlayer.addPeriodicTimeObserver(forInterval: interval, queue: nil, using: { [weak self] (time) in
            guard let self = self else { return }
            self.trackDetailView.currentTimeLabel.text = time.toDisplayString()
            let durationTime = self.player.avPlayer.currentItem?.duration
            let currentDurationText = ((durationTime ?? CMTimeMake(value: 1, timescale: 1)) - time).toDisplayString()
            self.trackDetailView.durationLabel.text = "-\(currentDurationText)"
            self.updateCurrentTimeSlider()
        })
    }
    
    func updateCurrentTimeSlider() {
        let currentTimeSeconds = CMTimeGetSeconds(player.avPlayer.currentTime())
        let durationSeconds = CMTimeGetSeconds(player.avPlayer.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage = currentTimeSeconds / durationSeconds
        self.trackDetailView.currentTimeSlider.value = Float(percentage)
    }
}
